Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289866AbSAXA4W>; Wed, 23 Jan 2002 19:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290229AbSAXA4M>; Wed, 23 Jan 2002 19:56:12 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:34438 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id <S289866AbSAXA4G>; Wed, 23 Jan 2002 19:56:06 -0500
Message-ID: <313680C9A886D511A06000204840E1CF40B60E@whq-msgusr-02.pit.comms.marconi.com>
From: "Punj, Arun" <Arun.Punj@marconi.com>
To: "'Eric Weigle'" <ehw@lanl.gov>, "Punj, Arun" <Arun.Punj@marconi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: NEWBIE : can't find /lib/modules/2.4.17/modules.dep error
Date: Wed, 23 Jan 2002 19:55:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, You are right I did not do a make modules_install. 

However, the thing is  - my system was working normally in so far as I can
tell even without doing make modules_install !!! Maybe I am not using any
of dynamically loading drivers???

Thanks a ton eric and all who have helped.

ARun

> -----Original Message-----
> From: Eric Weigle [mailto:ehw@lanl.gov]
> Sent: Wednesday, January 23, 2002 7:16 PM
> To: Punj, Arun
> Cc: lkml
> Subject: Re: NEWBIE : can't find /lib/modules/2.4.17/modules.dep error
> 
> 
> > I upgraded the 2.4.7-10 kernel that comes with RH7.2 to 2.4.17. 
> > [ I could compile it fine and grub is able to load it too...]
> > 
> > However, I see the error : can't find 
> /lib/modules/2.4.17/modules.dep
> > multiple times.
> Sounds like you didn't make or install modules. Most kernels 
> these days
> are best built using modules for device drivers and such that 
> are loaded
> on-demand during runtime, instead of being part of a big 'monolithic'
> kernel. This saves space in memory and has some other 
> benefits (although
> this is open to debate).
> 
> `make bzImage` makes just the 'monolithic' part of the 
> kernel, while `make
> modules` and `make modules_install` handle building and 
> installing modules,
> and should create the proper directories and put in the 
> appropriate files.
> 
> If you did execute the modules commands (as root, of course), 
> the problem
> might be in your module loader program suite (insmod, lsmod, 
> etc.). Old
> versions of the program don't work with newer kernels. I'm 
> not a RedHat user
> so I wouldn't know about that, but you could check their site 
> and download
> the latest RPM if that seems to be the problem.
> 
> -Eric
> 
> -- 
> --------------------------------------------
>  Eric H. Weigle   CCS-1, RADIANT team
>  ehw@lanl.gov     Los Alamos National Lab
>  (505) 665-4937   http://home.lanl.gov/ehw/
> --------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


This e-mail and any attachments are confidential. If you are not the
intended recipient, please notify us immediately by reply e-mail and then
delete this message from your system. Do not copy this e-mail or any
attachment, use the contents for any purposes, or disclose the contents to
any other person: to do so could be a breach of confidence.
