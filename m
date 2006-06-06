Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWFFKHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWFFKHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 06:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFFKHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 06:07:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20880 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932122AbWFFKHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 06:07:24 -0400
Date: Tue, 6 Jun 2006 12:06:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual via-rhine on EPIA PD6000E
In-Reply-To: <448530FC.4020107@dgt.com.pl>
Message-ID: <Pine.LNX.4.61.0606061204500.27998@yvahk01.tjqt.qr>
References: <44843EFB.4030704@dgt.com.pl> <Pine.LNX.4.61.0606051629240.20741@yvahk01.tjqt.qr>
 <448530FC.4020107@dgt.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There is a difference between ioports and iomem.
>> 
> Of course I know, but look at this:
>
> # cat /proc/ioports
> d000-d0ff : 0000:00:0f.0
> d000-d0ff : via-rhine
> e400-e4ff : 0000:00:12.0
> e400-e4ff : via-rhine
>
> # cat /proc/iomem  de000000-de0000ff : 0000:00:0f.0
> de000000-de0000ff : via-rhine
> de002000-de0020ff : 0000:00:12.0
> de002000-de0020ff : via-rhine
>
> from ifoconfig:
> eth0: Interrupt:10 Base address: *0xe000*
> eth1: Interrupt:11 Base address: *0x4000* <<is it I/O or mem ???

ioport.
ioports only go up to 0xffff, and iomem does not normally start below 
0xffff.

0x4000 and 0xe000 look strange though (they don't match /proc/ioports).


Jan Engelhardt
-- 
