Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTJUILZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTJUILZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:11:25 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:50441 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263012AbTJUILY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:11:24 -0400
Date: Tue, 21 Oct 2003 09:11:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Mike Christie <mikenc@us.ibm.com>
Subject: Re: [patch] qlogic_cs: init legacy_hosts
Message-ID: <20031021091118.A22761@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Mike Christie <mikenc@us.ibm.com>
References: <20031020232523.GD473@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031020232523.GD473@cathedrallabs.org>; from aris@cathedrallabs.org on Mon, Oct 20, 2003 at 09:25:23PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 09:25:23PM -0200, Aristeu Sergio Rozanski Filho wrote:
> -- 
> aris
> 

> --- linux/drivers/scsi/pcmcia/qlogic_stub.c.orig	2003-10-20 21:04:02.000000000 -0200
> +++ linux/drivers/scsi/pcmcia/qlogic_stub.c	2003-10-20 21:05:02.000000000 -0200
> @@ -249,6 +249,8 @@
>  	else
>  		qlogicfas_preset(link->io.BasePort1, link->irq.AssignedIRQ);
>  
> +	INIT_LIST_HEAD(&qlogicfas_driver_template.legacy_hosts);
> +

qlogic_cs is a newstyle driver, no need to initialize it.

