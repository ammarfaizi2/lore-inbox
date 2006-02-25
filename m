Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWBYWKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWBYWKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWBYWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:10:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:54993 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932074AbWBYWKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:10:41 -0500
Date: Sat, 25 Feb 2006 23:10:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Michael Buesch <mbuesch@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Mapping to 0x0
In-Reply-To: <BE7AD56A-27CA-465C-A4C6-774E8C074EF0@mac.com>
Message-ID: <Pine.LNX.4.61.0602252309150.10677@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
 <200602241237.21628.mbuesch@freenet.de> <BE7AD56A-27CA-465C-A4C6-774E8C074EF0@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am playing around with it. I did the attached code. It is a usermode
>> program, which tries to map NULL, and a kernel module, which calls a NULL
>> pointer. The file badcode.bin contains an i386 ud2 instruction. When
>> loading the kernel module, while the usermode program is executing, I get
>> the usual NULL pointer dereference oops:
>
> You need to trigger the null pointer dereference from within the userspace
> program that maps NULL.  The reason your test doesn't do anything is that it is
> the insmod tool whose address space gets used, as opposed to your nulltest
> program.
>

Think of a device driver which dereferences on read() or write() or ioctl.
Then the userspace program gets its chance, does not it?



Jan Engelhardt
-- 
