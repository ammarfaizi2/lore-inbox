Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbULBSAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbULBSAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULBSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:00:09 -0500
Received: from holomorphy.com ([207.189.100.168]:44209 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261689AbULBR4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:56:45 -0500
Date: Thu, 2 Dec 2004 09:56:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephan van Hienen <kernel@a2000.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure (2.6.10-rc2)
Message-ID: <20041202175636.GA2714@holomorphy.com>
References: <Pine.LNX.4.61.0412021846220.16787@adsl.a2000.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412021846220.16787@adsl.a2000.nu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 06:47:52PM +0100, Stephan van Hienen wrote:
> Today got this error :
> (system didn't crash it's still running) :
> swapper: page allocation failure. order:0, mode:0x20
>  [<c0136b22>] __alloc_pages+0x1b9/0x356
>  [<c0136ce4>] __get_free_pages+0x25/0x3f
>  [<c013a032>] kmem_getpages+0x21/0xcd
>  [<c013ab51>] alloc_slabmgmt+0x55/0x60
>  [<c013acf3>] cache_grow+0xca/0x16f
>  [<c013ae7a>] cache_alloc_refill+0xe2/0x21b
>  [<c013b23c>] __kmalloc+0x73/0x7a
>  [<c03594ed>] alloc_skb+0x47/0xe0

This is unusual enough to report, but not a sign of a problem in
isolation. If you get a large number of these (e.g. the console is
flooded with these and the system is unresponsive) there may be
something to worry about.


-- wli
