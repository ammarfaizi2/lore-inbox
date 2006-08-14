Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932706AbWHNUPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWHNUPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWHNUPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 16:15:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59803
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932696AbWHNUPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 16:15:20 -0400
Date: Mon, 14 Aug 2006 13:15:17 -0700 (PDT)
Message-Id: <20060814.131517.125893128.davem@davemloft.net>
To: rick.jones2@hp.com
Cc: johnpol@2ka.mipt.ru, kaos@ocs.com.au, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44E0B61F.3000706@hp.com>
References: <9286.1155557268@ocs10w.ocs.com.au>
	<20060814122049.GC18321@2ka.mipt.ru>
	<44E0B61F.3000706@hp.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Jones <rick.jones2@hp.com>
Date: Mon, 14 Aug 2006 10:42:55 -0700

> Now, PA-RISC CPUs have the ability to disable spaceid hashing, and it is 
> entirely possible that the PA-RISC linux port does that, but I thought I 
> would mention it as an example.  I'm sure the "official" PA-RISC linux 
> folks can expand on that much much better than I can.

Regardless, the "offset" it usually taken care of transparently
by the kernel in order to avoid cache aliasing issues.

It is definitely something we'll need to deal with for zero-copy
I/O using NTA.  We'll have to make sure that the user mapping of
the page is of the same color as the mapping the kernel uses.
