Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbULUHKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbULUHKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbULUHKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:10:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:28079 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261522AbULUHKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:10:43 -0500
Subject: Re: [PATCH] add PCI API to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org
In-Reply-To: <20041220225817.GA21404@kroah.com>
References: <200412201450.47952.jbarnes@engr.sgi.com>
	 <20041220225817.GA21404@kroah.com>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 08:10:04 +0100
Message-Id: <1103613004.21771.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int mmap(struct file *file, struct vm_area_struct *vma)
> > +{

Also, just a style comment: I dislike when functions have such a
"generic" name like mmap. I'd _much_ prefer something like pcisysfs_mmap
or something like that. The simple name makes it confusing in
System.map/kallsyms and thus when debugging.


