Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWGKTvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWGKTvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGKTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:51:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWGKTvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:51:45 -0400
Date: Tue, 11 Jul 2006 12:51:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
In-Reply-To: <44B3FE34.9000704@zytor.com>
Message-ID: <Pine.LNX.4.64.0607111249380.5623@g5.osdl.org>
References: <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
 <20060711171624.GA16554@suse.de> <44B3DEA0.3010106@zytor.com>
 <20060711173030.GA16693@suse.de> <44B3E40E.2090306@zytor.com>
 <20060711180126.GB16869@suse.de> <44B3E814.3060004@zytor.com>
 <20060711181055.GC16869@suse.de> <44B3EB28.1050007@zytor.com>
 <20060711191548.GA17585@suse.de> <Pine.LNX.4.64.0607111226320.5623@g5.osdl.org>
 <44B3FE34.9000704@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jul 2006, H. Peter Anvin wrote:
> 
> Does that mean "in kernel space", "in the kernel distribution" or "in memory
> completely under the control by the kernel?"  That is really what this is
> about.

I think it's all about kernel space.

Moving the default parsing to user space would add exactly _zero_ 
advantage, and would add totally unnecessary complexity (ie now we need to 
make sure that hotplug does it right - and the hotplug routines suddenly 
change between the boot phase and the actual install).

		Linus
