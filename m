Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTIYTPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTIYTPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:15:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:63498 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261863AbTIYTPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:15:10 -0400
Date: Thu, 25 Sep 2003 20:15:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/19): xpram driver.
Message-ID: <20030925201505.A22993@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030925171917.GJ2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030925171917.GJ2951@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Thu, Sep 25, 2003 at 07:19:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 07:19:17PM +0200, Martin Schwidefsky wrote:
>  static xpram_device_t xpram_devices[XPRAM_MAX_DEVS];
> -static int xpram_sizes[XPRAM_MAX_DEVS];
> +static unsigned int xpram_sizes[XPRAM_MAX_DEVS];
>  static struct gendisk *xpram_disks[XPRAM_MAX_DEVS];

Btw, you should really consolidate all these per-device arrays
in a struct.  Maybe some day you even get rid of the artifical
limit on the number of devices :)

