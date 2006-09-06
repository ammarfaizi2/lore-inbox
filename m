Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWIFPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWIFPRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIFPRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:17:20 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:64183 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751394AbWIFPRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:17:19 -0400
Date: Wed, 6 Sep 2006 17:17:17 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/21] nbd: limit blk_queue
Message-ID: <20060906151716.GG16721@harddisk-recovery.com>
References: <20060906131630.793619000@chello.nl>> <20060906133954.845224000@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906133954.845224000@chello.nl>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 03:16:41PM +0200, Peter Zijlstra wrote:
> -		disk->queue = blk_init_queue(do_nbd_request, &nbd_lock);
> +		disk->queue = blk_init_queue_node_elv(do_nbd_request,
> +				&nbd_lock, -1, "noop");

So what happens if the noop scheduler isn't compiled into the kernel?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
