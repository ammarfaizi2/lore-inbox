Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVACKZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVACKZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 05:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVACKZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 05:25:41 -0500
Received: from [213.146.154.40] ([213.146.154.40]:47589 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261420AbVACKZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 05:25:37 -0500
Date: Mon, 3 Jan 2005 10:25:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103102535.GB17856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -ioctl-cleanup.patch
> -unlocked_ioctl.patch
> +ioctl-rework.patch
> 
>  New version of the dont-hold-BKL-across-ioctl patch.

For the native case the new naming is stupid.  The old ioctl_unlocked
made perfect sense while ioctl_native doesn't - after all ->ioctl is
native aswell.  Also this still has the useless inode * paramater in
the method signature.

