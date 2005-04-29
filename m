Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVD2IVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVD2IVU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVD2IVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:21:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:45953 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262255AbVD2IVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:21:17 -0400
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: David Addison <addy@quadrics.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <42708EE9.3010503@ens-lyon.org>
References: <426E62ED.5090803@quadrics.com>  <42708EE9.3010503@ens-lyon.org>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 18:19:32 +1000
Message-Id: <1114762772.7183.285.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip)
> > +{
> > +	ip->next = mm->ioproc_ops;
> > +	mm->ioproc_ops = ip;
> > +
> > +	return 0;
> > +}
> > +

Why not use a list_head along with linux standard list primitives ?

Ben.


