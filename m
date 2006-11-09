Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754301AbWKICnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbWKICnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 21:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbWKICnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 21:43:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56994
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753543AbWKICns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 21:43:48 -0500
Date: Wed, 08 Nov 2006 18:43:53 -0800 (PST)
Message-Id: <20061108.184353.106435332.davem@davemloft.net>
To: jesse.brandeburg@gmail.com
Cc: jmerkey@soleranetworks.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: e1000 driver 2.6.18 - how to waste processor cycles
From: David Miller <davem@davemloft.net>
In-Reply-To: <4807377b0611081701i26ee7ce0k1f822dbbe52c2c8@mail.gmail.com>
References: <45524E3A.7080301@soleranetworks.com>
	<4807377b0611081701i26ee7ce0k1f822dbbe52c2c8@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Date: Wed, 8 Nov 2006 17:01:44 -0800

> If you can show that it is faster to use pci_dma_sync_single_for_cpu
> and friends I'd be glad to take a patch.

The problem is if you don't recycle the buffer and really unmap,
you'll flush twice.  That can potentially be expensive.
