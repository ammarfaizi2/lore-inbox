Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbRLRF5K>; Tue, 18 Dec 2001 00:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285591AbRLRF5A>; Tue, 18 Dec 2001 00:57:00 -0500
Received: from ns2.generalbroadband.com ([64.32.62.5]:17678 "EHLO
	mx1.relaypoint.net") by vger.kernel.org with ESMTP
	id <S285589AbRLRF4x>; Tue, 18 Dec 2001 00:56:53 -0500
To: linux-kernel@vger.kernel.org
From: Greg Pomerantz <gmp@alumni.brown.edu>
Subject: i810_audio mono troubles
Date: Mon, 17 Dec 2001 23:57:04 -0500
Message-ID: <auto-000001925281@mx1.relaypoint.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monaural audio streams on my Sony Vaio PCG-R505TSK play at double speed
under Debian woody / kernel 2.4.16. I've written a quick hack to fix
it, and I was curious if this problem is affecting anybody else, or if
it is specific to my platform. I have been communicating with a number
of people on the linux-sony mailing list who are also having what appear
to be sample-rate related problems with the i810s in Sony Vaios.

Just posting this to make all of theiti810 fans aware of this. My patch
is most likely not the right way to do things, but it does work... I am
particularly curious to hear if I am doing the right thing with
I810_FMT_STEREO.

This patch was made against 2.4.16, but it applies fine (offset -4
lines) against 2.4.17-rc1. My platform is Debian woody, kernel 2.4.16.
My i810 vital statistics:

  Intel 810 + AC97 Audio, version 0.04, 23:16:04 Dec 17 2001
  PCI: Found IRQ 5 for device 00:1f.5
  PCI: Sharing IRQ 5 with 00:1f.3
  PCI: Sharing IRQ 5 with 00:1f.6
  PCI: Setting latency timer of device 00:1f.5 to 64
  i810: Intel ICH2 found at IO 0x1840 and 0x1c00, IRQ 5
  i810_audio: Audio Controller supports 6 channels.
  ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
  i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), total channels = 2
  ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
  i810_audio: timed out waiting for codec 1 analog ready


Take care,

Greg Pomerantz

#text/plain;name=patch-i810-mono-2.4.16 /home/gmp/work/stuff/patch-i810-mono-2.4.16

