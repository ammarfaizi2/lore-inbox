Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTJUJ6C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbTJUJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:58:01 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:24331 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262562AbTJUJ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:58:00 -0400
Date: Tue, 21 Oct 2003 10:57:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Mike Christie <mikenc@us.ibm.com>
Subject: Re: [patch] qlogic_cs: init legacy_hosts
Message-ID: <20031021105757.A24895@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Mike Christie <mikenc@us.ibm.com>
References: <20031020232523.GD473@cathedrallabs.org> <20031021091118.A22761@infradead.org> <20031021092858.GA8632@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031021092858.GA8632@cathedrallabs.org>; from aris@cathedrallabs.org on Tue, Oct 21, 2003 at 07:28:58AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 07:28:58AM -0200, Aristeu Sergio Rozanski Filho wrote:
> hi Christoph,
> > > @@ -249,6 +249,8 @@
> > >  	else
> > >  		qlogicfas_preset(link->io.BasePort1, link->irq.AssignedIRQ);
> > >  
> > > +	INIT_LIST_HEAD(&qlogicfas_driver_template.legacy_hosts);
> > > +
> > 
> > qlogic_cs is a newstyle driver, no need to initialize it.
> then it needs more work. without initializing it i get an oops in
> scsi_register(). i guess the qlogic_cs is an oldstyle driver by now
> because it uses qlogicfas template and functions.

why do you call scsi_register at all?  You need to uses scsi_host_alloc in
the pcmcia case.

