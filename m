Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315201AbSD3T74>; Tue, 30 Apr 2002 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSD3T7z>; Tue, 30 Apr 2002 15:59:55 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:11186 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S315201AbSD3T7y>;
	Tue, 30 Apr 2002 15:59:54 -0400
Date: Tue, 30 Apr 2002 20:56:42 +0100
Message-Id: <200204301956.g3UJug012891@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
cc: linux-kernel@vger.kernel.org
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: How to write portable MMIO code?
In-Reply-To: <Pine.LNX.4.44.0204301112520.32217-100000@chaos.physics.uiowa.edu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0204301112520.32217-100000@chaos.physics.uiowa.edu> you wrote:
>>   - should one in general (i.e., assuming the worst case) do wmb() on 
>> writes, and mb() on reads?

readl() and writel() are specified to contain the proper barriers already.

 
> I don't think mb() will help you. You're probably experiencing PCI posting 
> problems - when a writel() has executed, that doesn't necessarily mean 
> that the transaction has actually happened it may (and will) be buffered 
> for a potentially long time.
> 
> However, PCI won't reorder reads vs. writes, so you when you want to be 
> sure that a write() actually reached the hardware, do a dummy read() 
> afterwards, that'll flush the write buffer.

yup
