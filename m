Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWIFPbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWIFPbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWIFPbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:31:40 -0400
Received: from gate.perex.cz ([85.132.177.35]:4299 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S1751456AbWIFPbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:31:39 -0400
Date: Wed, 6 Sep 2006 17:31:37 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: LKML <linux-kernel@vger.kernel.org>
Subject: ALSA planed changes for 2.6.19
Message-ID: <Pine.LNX.4.61.0609061729070.9343@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a short summary of ALSA changes planed to merge into 2.6.19.
All changes are in GIT tree [1].

* core changes
  - Control API - TLV implementation
    This extension implements a TLV mechanism to transfer an additional
    information like dB scale to the user space. Most of drivers were
    updated to support dB scale information.
  - system timer: cleanups, fixes
  - hotplug changes
    + snd /proc interface - fix disconnection
    + unregister device files at disconnection
    + deprecate snd_card_free_in_thread()
  - Add pcm_class attribute to PCM sysfs entry
* AC97 codec
  - add experimental support of aggressive AC97 power-saving mode
  - add codec-specific controls for UCB1400
* HDA codec
  - a lot of codec specific updates
  - add independent headphone volume control
  - enable center/LFE speaker on some laptops
* intel-hda - Switch to polling mode for CORB/RIRB communication
* emu10k1 - Implement 24bit capture via Philips 1361T ADC for SB0240 card
* add snd-mts64 driver for ESI Miditerminal 4140
* es18xx - Add PnP BIOS support
* ice1724 - Revolution 5.1 support
* sparc dbri updates
* hdsp - Fix auto-updating of firmware
* usbaudio - Support for non-standard rates in USB audio driver

[1] http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa-current.git
    http://www.kernel.org/git/?p=linux/kernel/git/perex/alsa-current.git

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
