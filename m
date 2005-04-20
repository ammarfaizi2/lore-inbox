Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVDTTmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVDTTmw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDTTmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:42:52 -0400
Received: from mail.dif.dk ([193.138.115.101]:53941 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261702AbVDTTmo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:42:44 -0400
Date: Wed, 20 Apr 2005 21:45:46 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce4 ide problems?
In-Reply-To: <2a4f155d050420081220b3f801@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0504202142030.2071@dragon.hyggekrogen.localhost>
References: <2a4f155d050420081220b3f801@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005, ismail dönmez wrote:

> Hi all,
> I recently bought an Asus A8N-SLI mobo and an AMD 3500+ CPU for my
> system but my ide drive seems to have some problems with them. Here is
> what I get at boot :
> <snip>
> hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
> hda: cache flushes supported
>  /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 {
> DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> </snip>
> First I thought it was bad ide cable ( because I wasn't using the one
> that came with mobo ) so I tried with the brand new cable coming with
> mobo and same error happened. Also trying to do something like :
> hdparm -m16 -c -u1 -d1 -Xudma2 /dev/hda
> results in a cpu exception thrown and a kernel panic after that. Full

You might want to post that Oops message if you want someone to try and 
fix it.

Also, from your dmesg output I see that you are loading the NVIDIA module
 NVRM: loading NVIDIA Linux x86_64 NVIDIA Kernel Module  1.0-7174  Tue Mar 22 06:45:40 PST 2005
You may want to try /not/ loading that module and then reproduce the 
kernel panic and then post that Oops or panic message instead.

-- 
Jesper Juhl

