Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbVCICW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVCICW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVCICW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:22:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261437AbVCICUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 21:20:07 -0500
Date: Wed, 9 Mar 2005 02:20:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Jens Axboe'" <axboe@suse.de>
Subject: Re: Direct io on block device has performance regression on 2.6.x kernel - fix sync I/O path
Message-ID: <20050309022002.GA23577@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, 'Andrew Morton' <akpm@osdl.org>,
	'Jens Axboe' <axboe@suse.de>
References: <200503090145.j291j7g16386@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503090145.j291j7g16386@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.9/drivers/char/raw.c	2004-10-18 14:54:37.000000000 -0700
> +++ linux-2.6.9.ken/drivers/char/raw.c	2005-03-08 17:22:07.000000000 -0800

this is not the blockdevice, but the obsolete raw device driver.  Please
benchmark and if nessecary fix the blockdevice O_DIRECT codepath insted
as the raw driver is slowly going away.

