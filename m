Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSKQWMn>; Sun, 17 Nov 2002 17:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbSKQWMn>; Sun, 17 Nov 2002 17:12:43 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:62667 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S266967AbSKQWMm>;
	Sun, 17 Nov 2002 17:12:42 -0500
Date: Sun, 17 Nov 2002 23:19:35 +0100
From: Magnus =?iso-8859-1?Q?M=E5nsson?= <ganja@0x63.nu>
To: linux-kernel@vger.kernel.org
Cc: Magnus =?iso-8859-1?Q?M=E5nsson?= <ganja@0x63.nu>
Subject: RequestIRQ: Resource in use. 2.4.20-rc2
Message-ID: <20021117221935.GI4722@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having a problem with my PCMCIA in my Dell Inspiron 8200. 
In kernel 2.4.19 my pcmcia-cards works perfactly but in 2.4.20-rc1 and
2.4.20-rc2 I am getting the same error on both my pcmcia cards (one 802.11b
wireless card of model D-Link DWL-650 and one 3com card 10/100Mb of some
kind).
pcmcia-cs version 3.2.2-1 is used though I am running debian unstable.

I am getting the following in my syslog when I insert one of the cards:
---
Nov 17 21:59:54 freija cardmgr[231]: socket 1: Intersil PRISM2 11 Mbps
Wireless Adapter
Nov 17 21:59:55 freija cardmgr[231]: executing: 'modprobe orinoco_cs'
Nov 17 21:59:55 freija kernel: hermes.c: 5 Apr 2002 David Gibson
<hermes@gibson.dropbear.id.au>
Nov 17 21:59:55 freija kernel: orinoco.c 0.11b (David Gibson
<hermes@gibson.dropbear.id.au> and others)
Nov 17 21:59:55 freija kernel: orinoco_cs.c 0.11b (David Gibson
<hermes@gibson.dropbear.id.au> and others)
Nov 17 21:59:55 freija kernel: orinoco_cs: RequestIRQ: Resource in use
Nov 17 21:59:56 freija cardmgr[231]: get dev info on socket 1 failed:
Resource temporarily unavailable
---

I have tried various combinations of irq-excludes in my
/etc/pcmcia/config.opts without any difference at all.
Another interesting thing is that I am not able to build pcmcia as
modules, but imbedded in the kernel goes fine.
I haven't found anything about this problem at the lkml and I hope someone
has an answer to me.

The following is from my config file belonging to the kernels I have
compiled, I hope only the PCMCIA/CardBus-part is interesting. (I think I
have a I82365, but since that didn't work I compiled them both in).
---
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
# CONFIG_TCIC is not set
CONFIG_I82092=y
CONFIG_I82365=y
---


Please cc me though I am not subscribed to the the list.
Thanks

-- 
Magnus Månsson
