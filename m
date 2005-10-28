Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030520AbVJ1SII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbVJ1SII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVJ1SII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:08:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030520AbVJ1SIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:08:07 -0400
Date: Fri, 28 Oct 2005 19:08:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, mpeschke@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/14] s390: statistics infrastructure.
Message-ID: <20051028180801.GA7875@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	mpeschke@de.ibm.com, linux-kernel@vger.kernel.org
References: <20051028140617.GA7300@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028140617.GA7300@skybase.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 04:06:17PM +0200, Martin Schwidefsky wrote:
> From: Martin Peschke <mpeschke@de.ibm.com>
> 
> [patch 1/14] s390: statistics infrastructure.
> 
> Add the statistics facility. This features offers a simple way to
> gather statistical data and to display them via the debugfs.
> An example how this is used:
> 
> 	struct statistic_interface *stat_if;
> 	struct statistic *stat;
> 
> 	statistic_interface_create(&stat_if, "whatever");
> 	statistic_create(&stat, stat_if, "stat-name", "unit");
> 	statistic_define_value(stat, range_min, range_max, def_mode);
> 	...
> 	statistic_inc(stat, value);	/* repeat.. */
> 	...
> 	statistic_interface_remove(&stat_if);

This certainly doesn't belong into arch code.  Please move to common
code and send over to lkml for detailed review.

