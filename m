Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTH3CIo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTH3CIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 22:08:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3300 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262260AbTH3CIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 22:08:43 -0400
Date: Sat, 30 Aug 2003 03:08:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       davidm@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org,
       matthew.e.tolentino@intel.com
Subject: Re: [PATCH] efivars update
Message-ID: <20030830020841.GD13467@parcelfarce.linux.theplanet.co.uk>
References: <200308292124.h7TLOCAZ000785@snoqualmie.dp.intel.com> <Pine.LNX.4.33.0308291448340.944-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0308291448340.944-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 02:59:43PM -0700, Patrick Mochel wrote:
> That patch is below. I'll be sending it to Linus once he gets back from
> vacation, unless anyone has any serious objections to it. Note that it
> completely removes any limitation on the length of a kobject (and sysfs
> directory) name.

Why keep another copy of the name?  Why not use kobj->dentry->qstr->name?
I thoroughly approve of kobject_name() though -- hide the implementation.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
