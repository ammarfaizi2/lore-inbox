Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266254AbUGJOMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266254AbUGJOMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 10:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUGJOMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 10:12:17 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:6855 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266254AbUGJOMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 10:12:15 -0400
Message-ID: <2a4f155d040710071244057045@mail.gmail.com>
Date: Sat, 10 Jul 2004 17:12:14 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Roger Larsson <roger.larsson@norran.net>
Subject: Re: (att. ismail) [announce] [patch] Voluntary Kernel Preemption Patch
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200407101503.58124.roger.larsson@norran.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200407101503.58124.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made artswrapper suid root. It's still skipping during cp -rf
big_folder copy operation. Jack is running with --realtime and I use
realtime lsm module to give it realtime capabilities.

doing a modprobe realtime gid=17

where 17 is "audio" group which happens to contain "cartman" user too.

On Sat, 10 Jul 2004 15:03:58 +0200, Roger Larsson
<roger.larsson@norran.net> wrote:
> > Tested on 2.6.7-bk20, Pentium3 700 mhz, 576 mb RAM
> >
> > I did cp -rf big_folder new_folder . Then opened up a gui ftp client
> > and music in amarok started to skip like for 2-3 seconds.
> >
> > Btw Amarok uses Artsd ( KDE Sound Daemon ) which in turn set to use
> > Jack Alsa Backend.
> 
> Are you sure that both artsd and jackd is run as RT processes?
> artsd needs 'artswrapper' as suid root and option in kconfig enabled.
> (never versions of amarok warns the user if this is not the case...)
> 
> [You can try to run the same as root to be sure]
> 
> But it does sound as a io scheduler problem - but 2-3 seconds!?
> 
> /RogerL
> 
> --
> Roger Larsson
> Skellefteå
> Sweden
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Time is what you make of it
