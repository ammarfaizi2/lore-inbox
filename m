Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUHOLUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUHOLUl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 07:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUHOLUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 07:20:41 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20400 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266595AbUHOLI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 07:08:28 -0400
Date: Sun, 15 Aug 2004 13:06:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: George Georgalis <george@galis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.8.1 EIP is at velocity_netdev_event+0x16/0x50
Message-ID: <20040815110625.GA2829@electric-eye.fr.zoreil.com>
References: <20040815095814.GA32195@trot.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815095814.GA32195@trot.local>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Georgalis <george@galis.org> :
[...]
> Unable to handle kernel NULL pointer dereference at virtual address 000000e4
>  printing eip:
> c03034d6
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<c03034d6>]    Not tainted
> EFLAGS: 00010282   (2.6.8.1) 
> EIP is at velocity_netdev_event+0x16/0x50
> eax: 00000000   ebx: c060b724   ecx: 00000000   edx: f7d7dd60
> esi: f6d771e0   edi: 00000001   ebp: 0100007f   esp: f6ccdeb4
> ds: 007b   es: 007b   ss: 0068
> Process ifconfig (pid: 328, threadinfo=f6ccc000 task=f6ca80d0)

You may apply on top of your 2.6.8.1 kernel:
http://www.fr.zoreil.com/people/francois/misc/20040815-2.6.8-via-velocity-test.patch

It will sync the via-velocity driver with the one in 2.6.8-rc4-mm1.
It is supposed to fix this issue.

Once the patch is applied, it will be interesting to know if CONFIG_SUPEND
makes a difference or not.

Please add netdev@oss.sgi.com to the Cc:

--
Ueimor
