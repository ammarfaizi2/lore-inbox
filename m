Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVHXHlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVHXHlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVHXHlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:41:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48074 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750720AbVHXHlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:41:17 -0400
Date: Wed, 24 Aug 2005 08:41:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another libata TODO item
Message-ID: <20050824074116.GF24513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <430C10E7.9060502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430C10E7.9060502@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 02:17:11AM -0400, Jeff Garzik wrote:
> 
> Difficulty:  beginner / intermediate
> 
> Modern network drivers have a per-NIC list of debugging messages that 
> can be enabled/disabled at runtime, implemented as a bitmask named 
> 'msg_enable' in each driver.  VERY useful for tracing specific events 
> during debugging.  grep for 'msg_enable', 'netif_msg_', and 'NETIF_MSG_'.
> 
> To make libata debugging easier and more fine-grained, we should convert 
> DPRINTK/VPRINTK calls in libata to code that looks like
> 
> 	if (ata_msg_xxx(ap->msg_enable))
> 		printk(...)

Would be nice if you could move that one up to the scsi layer and combine
it with the existing scsi core loglevel handling.

