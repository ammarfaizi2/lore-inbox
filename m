Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVDFPqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVDFPqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVDFPqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:46:50 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:16105 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262231AbVDFPqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:46:33 -0400
Subject: Re: HELP:(VIPER BOARD)AC'97 controller driver for rtlinux(rtlinux core driver) 
From: "nitin ahuja" <nitin2ahuja@myrealbox.com>
To: nobin_matthew@yahoo.com
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Date: Wed, 06 Apr 2005 09:46:16 -0600
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1112802376.8c7c3afcnitin2ahuja@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
> I am trying to develop a codec driver (rtlinux 
> driver) from scratch. In Viper board (PXA255) 
> physical memory range 0x40000000-0x43FFFFFF is used 
> by the PXA255 peripherals.In that address range
> 0x40500000-0x405005FC is needed for AC'97 controller
> registers. Is this memory range is already mapped to
> virtual address space, else How to map this to 
> virtual address space.
>

You have to map this address range using "ioremap()". Data at address returned by ioremap can be accessed by calling readl(), writel() et al

>
> When i tried ioremap() it is giving same virtual
> address with different physical address(i tried
> ioremap with another driver(same board)with different
> physical memory address)
>

Same virtual address can point to different physical addresses depending upon how it is mapped.

Nitin

