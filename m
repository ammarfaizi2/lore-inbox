Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTIBQM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 12:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263960AbTIBQM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 12:12:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:20423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263956AbTIBQM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 12:12:26 -0400
Date: Tue, 2 Sep 2003 09:17:59 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Matthew Wilcox <willy@debian.org>
cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       <davidm@napali.hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>,
       <matthew.e.tolentino@intel.com>
Subject: Re: [PATCH] efivars update
In-Reply-To: <20030830020841.GD13467@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0309020912420.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That patch is below. I'll be sending it to Linus once he gets back from
> > vacation, unless anyone has any serious objections to it. Note that it
> > completely removes any limitation on the length of a kobject (and sysfs
> > directory) name.
> 
> Why keep another copy of the name?  Why not use kobj->dentry->qstr->name?

The problem is defining it. The dentry is not allocated until the kobject 
is registered, and we call through to sysfs. That's not so much a problem, 
but we'd have to pass the name along with the object down to sysfs in 
order to create the dentry, which would be a bit messy, IMO.


	Pat

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

> > That patch is below. I'll be sending it to Linus once he gets back from
> > vacation, unless anyone has any serious objections to it. Note that it
> > completely removes any limitation on the length of a kobject (and sysfs
> > directory) name.
> 
> Why keep another copy of the name?  Why not use kobj->dentry->qstr->name?

The problem is defining it. The dentry is not allocated until the kobject 
is registered, and we call through to sysfs. That's not so much a problem, 
but we'd have to pass the name along with the object down to sysfs in 
order to create the dentry, which would be a bit messy, IMO.


	Pat

