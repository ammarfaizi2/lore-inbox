Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUJWJWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUJWJWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 05:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUJWJWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 05:22:36 -0400
Received: from lucidpixels.com ([66.45.37.187]:35203 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263818AbUJWJWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 05:22:18 -0400
Date: Sat, 23 Oct 2004 05:22:14 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failures Return With 2.6.9+TSO patch.
In-Reply-To: <417A2106.7010804@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0410230522040.639@p500>
References: <Pine.LNX.4.61.0410230435150.4620@p500> <417A2106.7010804@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applying this patch now and I will let everyone know what happens, thanks.

On Sat, 23 Oct 2004, Nick Piggin wrote:

> Justin Piszcz wrote:
>> Kernel 2.6.9 w/TSO patch.
>> 
>> (most likely do to the e1000/nic/issue)
>> 
>> $ dmesg
>> gaim: page allocation failure. order:4, mode:0x21
>>  [<c01391a7>] __alloc_pages+0x247/0x3b0
>>  [<c0139328>] __get_free_pages+0x18/0x40
>>  [<c035c33a>] sound_alloc_dmap+0xaa/0x1b0
>>  [<c03648c0>] ad_mute+0x20/0x40
>>  [<c035c70f>] open_dmap+0x1f/0x100
>>  [<c035cb58>] DMAbuf_open+0x178/0x1d0
>>  [<c035a4fa>] audio_open+0xba/0x280
>>  [<c015d863>] cdev_get+0x53/0xc0
>>  [<c035968c>] sound_open+0xac/0x110
>>  [<c035898e>] soundcore_open+0x1ce/0x300
>>  [<c03587c0>] soundcore_open+0x0/0x300
>>  [<c015d524>] chrdev_open+0x104/0x250
>>  [<c015d420>] chrdev_open+0x0/0x250
>>  [<c0152d82>] dentry_open+0x1d2/0x270
>>  [<c0152b9c>] filp_open+0x5c/0x70
>>  [<c01049c8>] common_interrupt+0x18/0x20
>>  [<c0152e75>] get_unused_fd+0x55/0xf0
>>  [<c0152fd9>] sys_open+0x49/0x90
>>  [<c010405b>] syscall_call+0x7/0xb
>
> Ouch, 64K atomic DMA allocation.
>
> The DMA zone barely even keeps that much total memory free.
>
> The caller probably wants fixing, but you could try this patch...
>
