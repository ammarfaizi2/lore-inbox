Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266919AbUBGOHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 09:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUBGOHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 09:07:06 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:38858 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S266919AbUBGOHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 09:07:03 -0500
Date: Sat, 7 Feb 2004 16:06:53 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: jjluza <jjluza@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.6.3-rc1: No sound with nforce2 sound system
In-Reply-To: <200402071357.35566.jjluza@free.fr>
Message-ID: <Pine.LNX.4.58.0402071602580.2460@pnote.perex-int.cz>
References: <200402071357.35566.jjluza@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, jjluza wrote:

> I have an nforce2 motherboard with the sound module snd_intel8x0.
> I had no problem with sound with kernel 2.6.2-bk2.
> But now, aplay doesn't work anymore, enemy-territory too.
> Other programs like xmms, kde apps using arts, and play still works.
> I get an error message with enemy-territory :
> > /dev/dsp: Input/output error
> > Could not mmap /dev/dsp

We know about this bug. It's related to VRA detection which is failing for 
multichannel codecs in some cases. You may try to force your game to 
48000Hz/16-bit/stereo audio parameters until we can fix this bug - or look 
to Documentation/sound/alsa/OSS-Emulation.txt for hints to make quake 
working. Unfortunately no primary ALSA developer has access to this 
type of hardware so debugging is quite slow using e-mails.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
