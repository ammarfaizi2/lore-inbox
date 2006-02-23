Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWBWCFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWBWCFC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 21:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWBWCFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 21:05:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWBWCFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 21:05:00 -0500
Date: Wed, 22 Feb 2006 17:59:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: pbadari@us.ibm.com, hch@lst.de, mcao@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and
 mpage_readpages()
Message-Id: <20060222175923.784ce5de.akpm@osdl.org>
In-Reply-To: <20060223014004.GA900@frodo>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com>
	<20060222151216.GA22946@lst.de>
	<1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
	<20060222165942.GA25167@lst.de>
	<20060223014004.GA900@frodo>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> There's four extra bytes on an 88 byte structure (with sector_t
>  CONFIG'd at 64 bits)

oy, buffer_heads are 48 bytes - took a few months out of my life, that did.
That's where it most counts - memory-constrained non-LBD 32-bit platforms.

Making b_size size_t doesn't affect that, so..
