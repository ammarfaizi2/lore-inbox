Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSKNAcw>; Wed, 13 Nov 2002 19:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSKNAcw>; Wed, 13 Nov 2002 19:32:52 -0500
Received: from tomts21-srv.bellnexxia.net ([209.226.175.183]:43662 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264739AbSKNAcv>; Wed, 13 Nov 2002 19:32:51 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Modules fun with 2.5.47-mm2 (or -bk)
Date: Wed, 13 Nov 2002 19:39:42 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211131939.42477.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The recient modules changes are 'fun'.  

First the Docs have not been updated.  A quick search of lkml found Rusty's
new utilities...  After that booting worked a little better...

Here is what complains here:

Module ip_tables cannot be unloaded due to unsafe usage in net/ipv4/netfilter/ip_tables.c:1385
Module tulip cannot be unloaded due to unsafe usage in drivers/net/tulip/tulip_core.c:487
Module pl2303 cannot be unloaded due to unsafe usage in drivers/usb/serial/usb-serial.c:1408
Module snd cannot be unloaded due to unsafe usage in fs/proc/inode.c:204
Module agpgart cannot be unloaded due to unsafe usage in drivers/char/agp/agp.c:67
Module pppox cannot be unloaded due to unsafe usage in drivers/net/pppox.c:52

And these will not load at all.

via_rhine: Unknown symbol mii_ethtool_gset
matroxfb_base: Unknown symbol matroxfb_global_mxinfo
scsi_mod: Unknown symbol module_dummy_usage
usb_storage: Unknown symbol scsi_register

I also had to modprobe a few modules manually, for instance, psmouse...

The via_rhine load failure is a killer here - its connected to my DSL modem...

Hope this helps,
Ed Tomlinson
