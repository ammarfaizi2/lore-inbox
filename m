Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266235AbRGES4x>; Thu, 5 Jul 2001 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266230AbRGES4m>; Thu, 5 Jul 2001 14:56:42 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:55827 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266227AbRGES4d>; Thu, 5 Jul 2001 14:56:33 -0400
Date: Thu, 5 Jul 2001 14:56:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200107051856.f65IuXf29897@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <mailman.994340644.23368.linux-kernel2news@redhat.com>
In-Reply-To: <1011478953412.20010705152412@spylog.ru>  <15172.22988.643481.421716@notabene.cse.unsw.edu.au> <11486070195.20010705172249@spylog.ru> <mailman.994340644.23368.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-kernel, you wrote:
> Peter Zaitsev wrote:
> > 
> > That's why I thought this problem is related to raid1 swapping I'm
> > using.
> 
> Well there is the potential problem that RAID1 has that it can't avoid allocating
> memory in some occasions, for the 2nd bufferhead. ATARAID raid0 has the same problem for
> now, and there is no real solution to this. You can pre-allocate a bunch of bufferheads,
> but under high load you will run out of those, no matter how many you pre-allocate.

Arjan, why doesn't it sleep instead (GFP_KERNEL)?

-- Pete
