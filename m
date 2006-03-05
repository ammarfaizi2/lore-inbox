Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCENPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCENPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 08:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWCENPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 08:15:05 -0500
Received: from relay1.wplus.net ([195.131.52.143]:18444 "EHLO relay1.wplus.net")
	by vger.kernel.org with ESMTP id S1750798AbWCENPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 08:15:03 -0500
From: Max Dmitrichenko <dmitrmax@rain.ifmo.ru>
Reply-To: dmitrmax@rain.ifmo.ru
Organization: IFMO
To: linux-kernel@vger.kernel.org
Subject: Problems with reading DVD-RW media
Date: Sun, 5 Mar 2006 16:17:32 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603051617.32455.dmitrmax@rain.ifmo.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've recently bought a new DVD-RW NEC ND-4551A device. First thing I did was
burning of two ISO images with stable Debian onto DVD-RW media. After these
images have been burned I've checked the MD5 sums and they were correct. But
now when I'm trying to read some files I've got Input/Output error. After I
load the disc into the drive, kernel begins to show error message every
second. The contents of this message is:

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
ide: failed opcode was: unknown

Some goggling showed that this could be DMA problem. But disabling DMA didn't
give any results.

The interest thing is that readcd still produces a valid image from this disc
and it has correct MD5 sum. So the problem is not in the media. Furthermore,
the disc can be perfectly read from Win2K in the VMWare environment when host
OS is my linux and independent of DMA settings.

Currently I'm running kernel 2.6.15. But this problem was noticed in 2.6.12 too.
The mainboard has i815 chipset.

Any idea what's wrong? Does anybody get this error too?

--
  Maxim Dmitrichenko
