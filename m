Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267465AbRGPRhP>; Mon, 16 Jul 2001 13:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267464AbRGPRg4>; Mon, 16 Jul 2001 13:36:56 -0400
Received: from dv1.dataventures.com ([207.188.144.122]:63165 "EHLO
	dv1.dataventures.com") by vger.kernel.org with ESMTP
	id <S267463AbRGPRgk>; Mon, 16 Jul 2001 13:36:40 -0400
Date: Mon, 16 Jul 2001 11:36:40 -0600 (MDT)
From: Donald Thompson <dlt@dataventures.com>
To: <linux-kernel@vger.kernel.org>
Subject: Stallion EasyIO and devfs
Message-ID: <Pine.LNX.4.31.0107161135530.13603-100000@dv1.dataventures.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a stallion EasyIO PCI 4 port card running on kernel 2.4.4.
Loading the stallion.o module does not seem to create the proper device files
for me using devfs.

Upon loading the module I get the following devices created:

/dev/ttyE
/dev/cue
/dev/staliomem/0
/dev/staliomem/1
/dev/staliomem/2
/dev/staliomem/3

I don't get /dev/ttyE0 through /dev/ttyE3 or /dev/ttyE/0 through
/dev/ttyE/3, which is what I believe should be happening.

I can make the devices using the mkdevnods script from the ata 5.5.0
stallion driver package, and sure enough ttyE0 through ttyE3 work as
expected. I can setup the devices at boot so I'm not dead in the water
with it.

Heres the output from /proc/pci regarding the card:
  Bus  0, device  20, function  0:
    Communication controller: Stallion Technologies, Inc. EasyIO (rev 1).
      IRQ 9.
      I/O at 0xf480 [0xf4ff].
      I/O at 0xf800 [0xf87f].

I'm using devfsd 1.3.11 on an up to date debian sid machine.

-Don


