Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTDGMM5 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTDGMM5 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:12:57 -0400
Received: from HDOfa-01p2-156.ppp11.odn.ad.jp ([61.116.131.156]:1168 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S263396AbTDGMLe (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:11:34 -0400
Date: Mon, 07 Apr 2003 21:23:07 +0900 (JST)
Message-Id: <20030407.212307.74751577.whatisthis@jcom.home.ne.jp>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7/PCI : Unable to attach Sound module of VIA686A 
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
In-Reply-To: <s5h1y0esjov.wl@alsa2.suse.de>
References: <20030405.230849.74749394.whatisthis@jcom.home.ne.jp>
	<s5h1y0esjov.wl@alsa2.suse.de>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi,
 
                     BINGO! :-)

Written by Takashi Iwai <tiwai@suse.de>
   at Mon, 07 Apr 2003 12:09:20 +0200 :
Subject: Re: 2.4.21-pre7/PCI : Unable to attach Sound module of VIA686A 

tiwai> At Sat, 05 Apr 2003 23:08:49 +0900 (JST),
tiwai> Kyuma Ohta wrote:
tiwai> > 
tiwai> > PCI: Found IRQ 10 for device 00:07.5
tiwai> > PCI: Sharing IRQ 10 with 00:0a.0
tiwai> > ALSA ../alsa-kernel/pci/via82xx.c:1786: unable to grab ports 0xdc00-0xdcff
tiwai>                                                                ^^^^^^^^^^^^^
tiwai> > VIA 82xx soundcard not found or device busy
tiwai> 
tiwai> something already occupies the i/o ports for via82xx.
tiwai> please check /proc/ioports.
tiwai> 
tiwai> do you use aic7xxx?

No,but aic7xxx driver includes as internal driver. 
Maybe,aic7xxx driver misdetects on VIA mainboard any devices  as aic SCSI 
(see below).

--- 2.4.21-pre6 ---
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
d800-d81f : VIA Technologies, Inc. USB (#2)
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  dc00-dcff : VIA686A
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e400-e401 : MPU401 UART
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e800-e8ff : 8139too
ec00-ecff : PCI device 1317:9511 (Linksys)
  ec00-ecff : tulip
----
--- 2.4.21-pre7 ---
bc00-bcff : aic7xxx
cc00-ccff : aic7xxx
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB (#2)
  d800-d81f : usb-uhci
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  dc00-dcff : aic7xxx
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e800-e8ff : 8139too
ec00-ecff : PCI device 1317:9511 (Linksys)
fc00-fcff : aic7xxx
---- 

Thanx,
Ohta
