Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967409AbWK3OsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967409AbWK3OsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 09:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936434AbWK3OsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 09:48:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45511 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936432AbWK3OsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 09:48:09 -0500
Date: Thu, 30 Nov 2006 14:48:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Eric Van Hensbergen <ericvh@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, ming@acis.ufl.edu,
       ericvh@gmail.com
Subject: Re: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Message-ID: <20061130144807.GA16474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@hera.kernel.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	ming@acis.ufl.edu, ericvh@gmail.com
References: <200611271826.kARIQYRi032717@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611271826.kARIQYRi032717@hera.kernel.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 06:26:34PM +0000, Eric Van Hensbergen wrote:
> This is the first cut of a device-mapper target which provides a write-back
> or write-through block cache.  It is intended to be used in conjunction with
> remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
> cluster situations.
> 
> In performance tests with iSCSI, gave peformance improvements of 2-10x that
> of iSCSI alone when Postmark or Bonnie loads were applied from 8 clients to
> a single server.  Evidence suggests even greater differences on larger
> clusters.  A detailed performance analysis will be vailable shortly via a
> technical report on IBM's CyberDigest.
> 
> This module was developed during an intership at IBM Research by
> Ming Zhao.  Please direct comments to both Ming and myself.

I don't quite understand the need for this.  Do you need this module
because your iscsi target doesn't use the pagecache on the server?

