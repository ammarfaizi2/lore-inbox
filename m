Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbUJ0Lop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUJ0Lop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUJ0Lop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:44:45 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:40347 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262386AbUJ0Lon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:44:43 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: sata related hang with linux-2.6
Date: Wed, 27 Oct 2004 11:44:42 +0000 (UTC)
Organization: Wurtelization
Message-ID: <clo1na$va8$1@news.cistron.nl>
References: <417EDFFC.4090004@home.nl>
X-Trace: ncc1701.cistron.net 1098877482 32072 195.64.88.114 (27 Oct 2004 11:44:42 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramon de Ruiter  <won@home.nl> wrote:
>
>About once every three times i power-on my pc, it won't load the OS.
>When the kernel is at the point of initializing my harddisk, it just
>hangs with error message:
>
>IRQ 10: Nobody cared!
>(the following about 20 times and with different codes and messages for 
>the "...":)
>[c01061da>] ...
>Disabling IRQ# 10 ata1: dev 0 ATA, max UDMA/100, 4d88960 sectors.
>
>I'm not able to capture it decently but perhaps i
>could make a decent photo of it if necessary.
>When this happens, i reset the system and then it boots just fine.
>
>I have a Abit motherboard with Nforce2 chipset and Silicon Image
>Sata(raid) controller (CONFIG_SCSI_SATA_SIL) I have a 20G ide disk

IMHO there's something not quite right with the Silicon Image libata
driver; I've encountered this "IRQ xx: Nobody cared!" with such a
controller in a number of (slower) systems. In that case, it never works
for me.  In other systems, it doesn't give the "nobody cared" message
during module loading, and then it works fine.

Perhaps the driver is enabling the hardware to generate interrupts
before setting up the interrupt routine for it? Please excuse my
ignorance if I'm talking nonsense here :-)

I can perform tests if necessary...


Paul Slootman

