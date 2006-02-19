Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWBSVmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBSVmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWBSVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:42:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12429 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932273AbWBSVmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:42:42 -0500
Date: Sun, 19 Feb 2006 22:42:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Mittendorfer <delist@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No sound from SB live!
Message-ID: <20060219214229.GK15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <200602190127.27862.ghrt@dial.kappa.ro> <20060218234805.GA3235@elf.ucw.cz> <20060219013313.17e91b04.delist@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219013313.17e91b04.delist@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried enabled everything I could in alsamixer, but still could not
> > get it to produce some sound :-(.
> 
> I usually use some simple mixer like rexima and a small .wav or .ogg 
> aplay/play/ogg123'ed for testing. 
> 
> Have one of those in a UP P3 here (but 2.6.15):

Mine output looks similar... pretty much okay. Set all in alsamixer to
max, plugged headphone-like speaker into green connector. No sound.

> Any message when you try to play a file? Or just no sound output, but
> progress while playing? 

Everything looks okay, but no sound. Nothing in dmesg.

root@hobit:~# mpg123
/usr/share/emacs/site-lisp/emacspeak/sounds/emacspeak.mp3
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!

Directory: /usr/share/emacs/site-lisp/emacspeak/sounds/
Playing MPEG stream from emacspeak.mp3 ...
MPEG 1.0 layer III, 128 kbit/s, 44100 Hz joint-stereo

[0:03] Decoding of emacspeak.mp3 finished.
root@hobit:~# dmesg | tail -5
EXT3-fs: mounted filesystem with ordered data mode.
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
coda_read_super: Bad mount data
coda_read_super: device index: 0
coda_read_super: No pseudo device
root@hobit:~#

aplay complains about nonexisting /dev/ files:

root@hobit:~#  aplay
/usr/share/xemacs21/xemacs-packages/etc/sounds/hammer.wav
aplay: main:533: audio open error: No such file or directory
root@hobit:~#

...I'll try to fix it.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
