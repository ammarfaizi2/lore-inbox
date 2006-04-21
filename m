Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWDUPtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDUPtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWDUPtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:49:17 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41926 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932364AbWDUPtQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:49:16 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com
In-Reply-To: <OFB753A28F.DD67C970-ON42257157.0051D51C-42257157.0052637A@de.ibm.com>
References: <OFB753A28F.DD67C970-ON42257157.0051D51C-42257157.0052637A@de.ibm.com>
Date: Fri, 21 Apr 2006 18:41:40 +0300
Message-Id: <1145634100.13191.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 16:59 +0200, Michael Holzheu wrote:
> > > +struct x_info_blk_hdr {
> > > +   __u8  npar;
> > > +   __u8  flags;
> > > +   __u16 tslice;
> > > +   __u16 phys_cpus;
> > > +   __u16 this_part;
> > > +   __u64 curtod1;
> > > +   __u64 curtod2;
> > > +   char reserved[40];
> > > +} __attribute__ ((packed));
> >
> > Couldn't you use endianess annotated types for these?
> 
> What are "endianess annotated types" ?

For example, __le16 and __be16 (search for __bitwise in
<linux/types.h>). You can use sparse to check for endianess erros in
your code if you us them.

				Pekka

