Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWE1Rez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWE1Rez (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWE1Rez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:34:55 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:63894 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750821AbWE1Rez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:34:55 -0400
Message-ID: <01d801c6827c$fba04ca0$1800a8c0@dcccs>
From: =?iso-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
Subject: Re: How to send a break? - dump from frozen 64bit linux
Date: Sun, 28 May 2006 19:34:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Haar János" <djani22@netcenter.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, May 28, 2006 6:17 PM
Subject: Re: How to send a break? - dump from frozen 64bit linux


> On 28/05/06, Haar János <djani22@netcenter.hu> wrote:
> >
> > Can somebody tell me, what is wrong exactly?
> >
> I can't tell you exactely what's wrong unfortunately, but after
> looking at your dump & dmesg I notice two things that might be worth
> trying to change :
>
> 1) You seem to be running without any swap space at all. I't usually a
> good idea always to have some swap configured - try adding a swap
> file.
> (note: I don't think this will help with your current problem, it's
> just a good thing to do generally).

Thanks for the idea!

I did thinking of it allready, but dropped, because:
I can only use swap _file_ in this config, and swapping into file is
relatively slow.
I am affraid, it will be slow down this system for some cases.
The system (programs) is relatively small next to the used buffers/caches,
and the kernel will swap out the rarely used programs to be able free up
memory for caching.
I think this is not too good idea on this system, what have allready 4GB of
memory.
The minimum free space is changeable thanks to VM.

Are you sure?

>
> 2) You should try the latest stable kernel. Currently that's 2.6.16.18
> (http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.18.tar.bz2).
> There have been lots of fixes added since 2.6.15.x and perhaps you are
> lucky that whatever is giving you trouble  has already been fixed in
> that kernel.

Hmm.
Last time, when i try the 2.6.16.x, i have lost close to 4000 users home,
and documents on XFS filesystem!
(a lot of directory have renamed to "/*" like this one: "/ost+found" in the
root.)
I don't want to try it again! :-)

>
>
> > Anyway, i interested about, how can i -a single user- interpret these
dump
> > to made error reporting more useful?
> >
> You can find some info in Documentation/sysrq.txt &
> Documentation/oops-tracing.txt .
> As for posting good error/bug reports, please read the REPORTING-BUGS
> file in the root of the kernel source dir.

Thanks, i will read this.

Anyway, this 64bit hanging issue is reproducible on my system. (normally
about daily, but if i try to trigger it, can be about 3-4x daily.)
If somebody is interested, please let me know, and i will send any useful
infos to debugging this! :-)

Cheers,
Janos


>
>
> -- 
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

