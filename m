Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWBSWH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWBSWH7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWBSWH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:07:59 -0500
Received: from secure.htb.at ([195.69.104.11]:62225 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1751049AbWBSWH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:07:58 -0500
Date: Sun, 19 Feb 2006 23:07:48 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No sound from SB live!
Message-Id: <20060219230748.318c42f3.delist@gmx.net>
In-Reply-To: <20060219214229.GK15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	<200602190127.27862.ghrt@dial.kappa.ro>
	<20060218234805.GA3235@elf.ucw.cz>
	<20060219013313.17e91b04.delist@gmx.net>
	<20060219214229.GK15311@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FAwid-0008AA-00*YwuiN.ae6KY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@ucw.cz> (Sun, 19 Feb 2006 22:42:29
+0100):
> Hi!

hi!
 
> > >[...]
> > 
> aplay complains about nonexisting /dev/ files:
> 
> root@hobit:~#  aplay
> /usr/share/xemacs21/xemacs-packages/etc/sounds/hammer.wav
> aplay: main:533: audio open error: No such file or directory
> root@hobit:~#
> 
> ...I'll try to fix it.

I think this is just to due missing oss (emulation) drivers. It's
snd_pcm_oss and snd_mixer_oss IIRC.

Anyway that "sounds" :) weired: There might be a mixer be muted or some
bobo with the driver.

I just looked into /proc/asound/cardX/pcm0p/sub0/status and it shows
progress when playing -- This _might_ mean that alsa is working. Did the
same on the box with the Live! now and got little bit lost by the amount
of channels, but it seems to be the same /pcm0p/sub0/status there.

> 								Pavel

sl ritch
