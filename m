Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130423AbQJ0NIk>; Fri, 27 Oct 2000 09:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130550AbQJ0NIa>; Fri, 27 Oct 2000 09:08:30 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:15634 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130548AbQJ0NI1>;
	Fri, 27 Oct 2000 09:08:27 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: <kernel@kvack.org>
Date: Fri, 27 Oct 2000 15:05:53 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.0-test9 + LFS
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B2447A922C7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 00 at 23:15, kernel@kvack.org wrote:
> On Thu, 26 Oct 2000, Wakko Warner wrote:

> > doing an ls -l shows:
> > ls: x: Value too large for defined data type
> > 
> > NOTE: this worked in 2.4.0-test6 and I believe it stopped working around
> > test8, but I'm not sure.  May have been around test7.
> 
> Previous kernels allowed up to 4gb to be returned by the old stat.
> Upgrade your glibc and fileutils -- most recent distributions (Red Hat,
> SuSE, ...) are LFS ready, and the only reports I've seen about this
> concerned Slackware.

And Debian :-( It is hard to get rid of such file - GNU 'rm' complains
too, as it tries to stat that file first :-( Fortunately

echo -n > x; rm x

works. I filled bugreport some time ago (when 2.1.94 come to woody), but 
it was closed, as there are no 2.4.x headers in Debian, so it is not 
possible to recompile glibc against them... Recompiling glibc is enough 
for woody, BTW.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
