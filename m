Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTJQMD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJQMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:03:26 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:16647 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263408AbTJQMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:03:25 -0400
Date: Fri, 17 Oct 2003 13:03:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
Subject: Re: [patch][3/3] qlogic: set host name before using scsi_host_alloc()
Message-ID: <20031017130324.C26699@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Brard Roudier <groudier@free.fr>
References: <20031016015449.GC1765@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031016015449.GC1765@cathedrallabs.org>; from aris@cathedrallabs.org on Wed, Oct 15, 2003 at 11:54:49PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	sprintf(qinfo,
> +		"Qlogicfas Driver version 0.46, chip %02X at %03X, IRQ %d, TPdma:%d",
> +		qltyp, qbase, qlirq, QL_TURBO_PDMA);
> +	host->name = qinfo;
> +

This should be

	.name		= "qlogicfas",

in the host template defintion instead, that makes the text const and
has no runtime overhead.

