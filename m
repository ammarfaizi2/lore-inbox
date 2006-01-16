Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWAPMNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWAPMNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWAPMNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:13:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2436 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750706AbWAPMNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:13:31 -0500
Date: Mon, 16 Jan 2006 12:13:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
       jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
Message-ID: <20060116121328.GA12871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
	jejb <james.bottomley@steeleye.com>
References: <20060115135728.7b13996d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115135728.7b13996d.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 01:57:28PM -0800, Randy.Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Put SATA into its own menu.  Reason:  using SCSI is an
> implementation detail that users need not know about.
> 
> Enabling SATA selects SCSI since SATA uses SCSI as a function
> library supplier.  It also enables BLK_DEV_SD since that is
> what SATA drives look like in Linux.

we'll soon support (or already do?) support sata atapi, when this
won't be true anymore.  Please never select scsi upper drivers from
lower drivers, this independence is the whole point of the layered
architecture.

