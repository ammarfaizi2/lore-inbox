Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWHWHfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHWHfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWHWHfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:35:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2179
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751444AbWHWHfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:35:17 -0400
Date: Wed, 23 Aug 2006 00:35:16 -0700 (PDT)
Message-Id: <20060823.003516.30182824.davem@davemloft.net>
To: akpm@osdl.org
Cc: johnpol@2ka.mipt.ru, sundell.software@gmail.com, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060823000758.5ebed7dd.akpm@osdl.org>
References: <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com>
	<20060823065659.GC24787@2ka.mipt.ru>
	<20060823000758.5ebed7dd.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 23 Aug 2006 00:07:58 -0700

> I wonder whether designing-in a millisecond granularity is the right thing
> to do.  If in a few years the kernel is running tickless with high-res clock
> interrupt sources, that might look a bit lumpy.
> 
> Switching it to a __u64 nanosecond counter would be basically free on
> 64-bit machines, and not very expensive on 32-bit, no?

If it ends up in a structure we'll need to use the "aligned_u64" type
in order to avoid problems with 32-bit x86 binaries running on 64-bit
kernels.
