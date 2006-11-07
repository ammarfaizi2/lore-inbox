Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753251AbWKGW3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbWKGW3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbWKGW3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:29:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31421 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753251AbWKGW3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:29:54 -0500
Date: Tue, 7 Nov 2006 22:29:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Amol Lad <amol@verismonetworks.com>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@steeleye.com,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/scsi/mca_53c9x.c : save_flags()/cli() removal
Message-ID: <20061107222946.GA20332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Amol Lad <amol@verismonetworks.com>, Andrew Morton <akpm@osdl.org>,
	James.Bottomley@steeleye.com,
	linux kernel <linux-kernel@vger.kernel.org>
References: <1162816931.22062.132.camel@amol.verismonetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162816931.22062.132.camel@amol.verismonetworks.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 06:12:11PM +0530, Amol Lad wrote:
> Replaced save_flags()/cli() with spin_lock alternatives

This patch has very little chance to work as-is because it only replaces
cli with spinlocks, but not the irq handler it's locking against.

