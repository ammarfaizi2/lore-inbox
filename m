Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132460AbQLHUw3>; Fri, 8 Dec 2000 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132667AbQLHUwT>; Fri, 8 Dec 2000 15:52:19 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:50704 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132460AbQLHUwN>;
	Fri, 8 Dec 2000 15:52:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Peter Berger <peterb@telerama.com>
Date: Fri, 8 Dec 2000 21:21:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F1BEC884C26@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Dec 00 at 14:43, Peter Berger wrote:
> > tg->created may be out of date
>   ... 
> > You can create it, count it, then up tg->created out of order
> 
> Well, you're right, but this is picking lint.  Making this change (see
> http://peterb.telerama.com/thread-test.c for the corrected version)
> certainly doesn't make the problem go away (nor would I expect it to).

Can you tell me again (private, probably), which problem do you have?

After I fixed source to get it to compile with -W -Wall -Werror
(missing includes, wrong parameters to main...), and compiling with 
-D_REENTRANT, I received nice ./a.out, which runs under 2.4.0-test12-pre7, 
glibc-2.2 both standalone and in gdb (gdb 5.0) (all tools except
kernel as of today woody). In gdb I had to do 
'handle SIG32 noprint nostop pass', as by default gdb stops on SIG32 
arrival...

Now it runs and runs and runs... I do not see any unreaped childrens.
After thread 100000 it finished.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
