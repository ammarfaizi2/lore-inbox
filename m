Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbSK3T2Z>; Sat, 30 Nov 2002 14:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbSK3T2Z>; Sat, 30 Nov 2002 14:28:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267287AbSK3T2Z>;
	Sat, 30 Nov 2002 14:28:25 -0500
Message-ID: <3DE912F6.5090306@pobox.com>
Date: Sat, 30 Nov 2002 14:35:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@holomorphy.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH][2.5] xircom_cb small cleanups
References: <Pine.LNX.4.44.0211122134430.24523-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.44.0211122134430.24523-100000@montezuma.mastecende.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks basically ok, but you should get together with Dave Jones 
and come up with a unified patch that also eliminates the 
private=kmalloc allocation by filling in init_etherdev's 2nd argument.

Both init_etherdev and alloc_etherdev allocate struct net_device* and 
dev->priv in a single allocation.  As an additional bonus, dev->priv is 
aligned on a 32-byte [not bit] boundary, and the entire area is zeroed 
with memset()

	Jeff



