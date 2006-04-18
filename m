Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWDRIuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDRIuJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWDRIuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:50:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:23451 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750716AbWDRIuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:50:07 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Flexible mem= parameter
Date: Tue, 18 Apr 2006 11:49:21 +0300
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0604140036510.4365@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604140036510.4365@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181149.22108.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 01:49, Jan Engelhardt wrote:
> Hello,
> 
> 
> mem= can be used to limit the amount of physical memory Linux uses. I 
> presume that when specifying mem=256M only the memory from 0x0 to 
> 0x10000000 is used. Is there a way to tune mem= so that it will use
> 0x70000000 to 0x80000000? (A compile-time change would suffice.)

On i386 this works:

"mem=exactmap mem=640K@0 mem=79M@1M"

> Background: I am trying to track down a nondeterministic (but 
> reproducible) segfault while building big projects like gcc or glibc. I do 
> not think it's a memory problem since it only showed up since I changed to 
> gcc 4.1.0 and tweaked it to use -mcpu=ultrasparc (rather than -mcpu=v7) by 
> default. I had been building gcc4 before with gcc3 a number of times w/o 
> problems. I did ran a userspace memtester for approx 20 hours (`memtest` 
> from debian).
--
vda
