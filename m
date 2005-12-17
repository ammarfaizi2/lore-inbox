Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVLQVBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVLQVBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLQVBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:01:50 -0500
Received: from [194.90.237.34] ([194.90.237.34]:52456 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S964942AbVLQVBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:01:50 -0500
Date: Sat, 17 Dec 2005 23:05:03 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmap_atomic slot collision
Message-ID: <20051217210503.GA19246@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051217123755.aaa73edf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217123755.aaa73edf.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:
> And lo, a bunch of places in the kernel are forgetting to disable local
> interrupts.  So if your ode is correctly coded as above, you can
> scribble
> on their kmap, but they cannot scribble on yours.

That seems to be what I'm seeing.

> Failing to disable local IRQs while taking KM_IRQn is a ghastly bug.
> I'll
> fix 'em up.
Thanks!
Pls Cc me on a patch, I'm not on the list.

-- 
MST
