Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTJUJdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTJUJdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:33:52 -0400
Received: from panda.sul.com.br ([200.219.150.4]:23821 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262827AbTJUJdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:33:51 -0400
Date: Tue, 21 Oct 2003 07:28:58 -0200
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Mike Christie <mikenc@us.ibm.com>
Subject: Re: [patch] qlogic_cs: init legacy_hosts
Message-ID: <20031021092858.GA8632@cathedrallabs.org>
References: <20031020232523.GD473@cathedrallabs.org> <20031021091118.A22761@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021091118.A22761@infradead.org>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Christoph,
> > @@ -249,6 +249,8 @@
> >  	else
> >  		qlogicfas_preset(link->io.BasePort1, link->irq.AssignedIRQ);
> >  
> > +	INIT_LIST_HEAD(&qlogicfas_driver_template.legacy_hosts);
> > +
> 
> qlogic_cs is a newstyle driver, no need to initialize it.
then it needs more work. without initializing it i get an oops in
scsi_register(). i guess the qlogic_cs is an oldstyle driver by now
because it uses qlogicfas template and functions.

--
aris

