Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTIJTUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbTIJTSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:18:25 -0400
Received: from port-212-202-40-6.reverse.qsc.de ([212.202.40.6]:62857 "EHLO
	schillernet.dyndns.org") by vger.kernel.org with ESMTP
	id S265605AbTIJTRU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:17:20 -0400
Date: Wed, 10 Sep 2003 21:15:09 +0000 (UTC)
Message-Id: <20030910.211509.184824199.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during PM-wake
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on an iBook, currently running 2.4.22-benh2, the dmasound_pmac does
not restore the mixer setting during PowerManagement resume. I need to
use e.g. umix or whatever to reset it - but a simple change on a mixer
value is enought to set a useful value.

The device in use:

Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
i2c-core.o: adapter mac-io 0 registered as adapter 2.
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
tas driver [TAS3004 driver V 0.3])
using i2c address: 0x35 from device-tree
i2c-core.o: driver TAS3004 driver V 0.3 registered.
i2c-core.o: client [tas Digital Equalizer] registered to adapter [mac-io 0](pos. 0).
Audio jack plugged, muting speakers.
AE-Init snapper mixer
PowerMac Snapper  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
Write will use    4 fragments of   32768 bytes as default

The code in tas3004_leave_sleep() looks ok so ... any idea (maybe I
need to add a printk do test if it is really called?)?

Sincerely yours,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.net/people/rene
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

