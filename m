Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277375AbRJEN2e>; Fri, 5 Oct 2001 09:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277376AbRJEN2X>; Fri, 5 Oct 2001 09:28:23 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:57097 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S277375AbRJEN2M>;
	Fri, 5 Oct 2001 09:28:12 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Padraig Brady <padraig@antefacto.com>
Date: Fri, 5 Oct 2001 15:27:39 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Finegrained a/c/mtime was Re: Directory notification pr
CC: Alex Larsson <alexl@redhat.com>, Ulrich Drepper <drepper@cygnus.com>,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <567F3237EED@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Oct 01 at 14:15, Padraig Brady wrote:
> >Another advantage of using the real time instead of a counter is that 
> >you can easily merge the both values into a single 64bit value and do
> >arithmetic on it in user space. With a generation counter you would need 
> >to work with number pairs, which is much more complex. 
> >
> ??
> if (file->mtime != mtime || file->gen_count != gen_count)
>      file_changed=1;

make needs comparing timestamps between two files. I cannot imagine
how you can get this working (without network filesystem you can
have global gen_count, but with network filesystem each server has
its own gen_count... and using world-wide nanoseconds instead of world-wide
gen_count looks much simpler to me ;-) )
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
