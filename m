Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUCRLam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUCRLam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:30:42 -0500
Received: from www01.ies.inet6.fr ([62.210.153.201]:60856 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262528AbUCRLaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:30:22 -0500
Message-ID: <40598849.1070409@inet6.fr>
Date: Thu, 18 Mar 2004 12:30:17 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: SiS APIC, hacker looking for docs/help, was : Re: 2.6.4 under heavy
 ioload disables sis5513 DMA
References: <opr410iiid4evsfm@smtp.pacific.net.th>
In-Reply-To: <opr410iiid4evsfm@smtp.pacific.net.th>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote the following on 03/18/2004 11:52 AM :
> Happens every few hours with heavy io and cpu load:
> 
> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
> 
> hda: DMA disabled
> ide0: reset: success
> 
> DMA auto-reenabled by boot time hdparm -k
> 

Hum, I'm wondering if -k is fully functionnal (hdparm man page hints 
that this isn't supported by all drives and I don't remember any 
success/failure stories here).

> lspci -vv
> 
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 

SiS chipset : is APIC functionnal ? (cat /proc/interrupts)

If not, I believe this might be the problem and the solutions still 
eludes me (I don't think the problem lies in the IDE driver but in APIC 
support).

I've 2 SiS based mainboards forced to use XT-PIC (SiS735 and SiS645 
based) here but without this kind of problems (everything works until I 
start to add to many PCI cards in one system...). I'm willing to start 
hacking around (mostly on the 645 as the 735 is an always-on system).

Is reading the arch/i386/kernel/*pic* files (and probably others) enough 
to start or is there somewhere else to look for information ?

Regards,
-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
    o              Siege social: 51, rue de Verdun - 92158 Suresnes
   /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
  / /\  /_  / /_   France
  \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
   Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10

