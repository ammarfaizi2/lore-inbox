Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWEBFiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWEBFiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEBFiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:38:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33725 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932377AbWEBFip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:38:45 -0400
Date: Mon, 1 May 2006 22:37:03 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Michael Holzheu <holzheu@de.ibm.com>,
       akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060502053703.GA12992@kroah.com>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com> <20060502052341.GD11150@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502052341.GD11150@vrfy.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 07:23:41AM +0200, Kay Sievers wrote:
> If the count of values handled in a transaction is not to high and it
> makes sense to group these values logically, why not just create an
> attribute group for every transaction, which creates dummy attributes
> to fill the values in, and use an "action" file in that group, that
> commits all the values at once to whatever target? That should fit into
> the ioctl use pattern, right?

That's what configfs can handle easier.  I think the issue is getting
stuff from the kernel in one atomic snapshot (all the different file
values from the same point in time.)

thanks,

greg k-h
