Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJUKLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 06:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTJUKLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 06:11:40 -0400
Received: from panda.sul.com.br ([200.219.150.4]:34321 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S262709AbTJUKLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 06:11:39 -0400
Date: Tue, 21 Oct 2003 08:06:49 -0200
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Mike Christie <mikenc@us.ibm.com>
Subject: Re: [patch] qlogic_cs: init legacy_hosts
Message-ID: <20031021100649.GA8945@cathedrallabs.org>
References: <20031020232523.GD473@cathedrallabs.org> <20031021091118.A22761@infradead.org> <20031021092858.GA8632@cathedrallabs.org> <20031021105757.A24895@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021105757.A24895@infradead.org>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > qlogic_cs is a newstyle driver, no need to initialize it.
> > then it needs more work. without initializing it i get an oops in
> > scsi_register(). i guess the qlogic_cs is an oldstyle driver by now
> > because it uses qlogicfas template and functions.
> 
> why do you call scsi_register at all?  You need to uses scsi_host_alloc in
> the pcmcia case.
actually qlogic_cs calls __qlogicfas_detect() that calls
scsi_register(). i'll work on this.

-- 
aris

