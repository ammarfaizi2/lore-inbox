Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWDMXTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWDMXTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWDMXTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:19:34 -0400
Received: from xenotime.net ([66.160.160.81]:38565 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965004AbWDMXTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:19:33 -0400
Date: Thu, 13 Apr 2006 16:21:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flexible mem= parameter
Message-Id: <20060413162159.5fd64b5e.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0604140036510.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0604140036510.4365@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006 00:49:12 +0200 (MEST) Jan Engelhardt wrote:

> Hello,
> 
> mem= can be used to limit the amount of physical memory Linux uses. I 
> presume that when specifying mem=256M only the memory from 0x0 to 
> 0x10000000 is used. Is there a way to tune mem= so that it will use
> 0x70000000 to 0x80000000? (A compile-time change would suffice.)
> 
> 
> Background: I am trying to track down a nondeterministic (but 
> reproducible) segfault while building big projects like gcc or glibc. I do 
> not think it's a memory problem since it only showed up since I changed to 
> gcc 4.1.0 and tweaked it to use -mcpu=ultrasparc (rather than -mcpu=v7) by 
> default. I had been building gcc4 before with gcc3 a number of times w/o 
> problems. I did ran a userspace memtester for approx 20 hours (`memtest` 
> from debian).

I've never tried it, but Documentation/kernel-parameters.txt
suggests using mem= along with memmap= to specify an exact memmap.

	memmap=nn[KMG]@ss[KMG]
			[KNL] Force usage of a specific region of memory
			Region of memory to be used, from ss to ss+nn.


Is this on a sparc system or are you just building sparc tools?
I don't know if memmap= works on sparc arch.

---
~Randy
