Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263642AbUEPPdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUEPPdR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUEPPdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:33:17 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:23424 "EHLO
	mail-relay-3.tiscali.i") by vger.kernel.org with ESMTP
	id S263642AbUEPPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:32:47 -0400
Date: Sun, 16 May 2004 17:33:06 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Sven Wilhelm <wilhelm@icecrash.com>
Subject: a
Message-ID: <20040516153306.GA4459@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A6972D.1090009@icecrash.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Wilhelm <wilhelm@icecrash.com> ha scritto:
> Hi list,
> 
> I have problems with the radeonfb on 2.6.6 and also the older 2.6er 
> releases.
[cut]
> radeonfb: Invalid ROM signature 0 should be 0xaa55
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, 
> System=166.00 MHz
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string: CPT CLAA150PA01
> radeonfb: detected LVDS panel size from BIOS: 1400x1050
> radeondb: BIOS provided dividers will be used
> radeonfb: Power Management enabled for Mobility chipsets
> radeonfb: ATI Radeon LW  DDR SGRAM 64 MB
> kobject_register failed for radeonfb (-17)
> Call Trace:
>  [<c0229982>] kobject_register+0x57/0x59
>  [<c0279e08>] bus_add_driver+0x4a/0x9d
>  [<c027a225>] driver_register+0x2f/0x33
>  [<c02332a2>] pci_create_newid_file+0x27/0x29
>  [<c02336a8>] pci_register_driver+0x5c/0x84
>  [<c0430737>] radeonfb_old_init+0xf/0x1d
>  [<c04305bb>] fbmem_init+0x9d/0xe8
>  [<c042cb28>] chr_dev_init+0x80/0x9e
>  [<c041a78e>] do_initcalls+0x28/0xb4
>  [<c012904a>] init_workqueues+0x17/0x31
>  [<c01002b4>] init+0x0/0x150
>  [<c01002ec>] init+0x38/0x150
>  [<c0104258>] kernel_thread_helper+0x0/0xb
>  [<c010425d>] kernel_thread_helper+0x5/0xb

You compiled in both radeon drivers. The old driver is complaining that
the PCI device is already taken by something else. Use only one driver.

Luca
-- 
Home: http://kronoz.cjb.net
Alcuni pensano che io sia una persona orribile, ma non e` vero. Ho il
cuore di un ragazzino - in un vaso sulla scrivania.
