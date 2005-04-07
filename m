Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVDGSuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVDGSuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVDGSuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:50:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:5073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262556AbVDGStk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:49:40 -0400
Date: Thu, 7 Apr 2005 11:49:18 -0700
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
Message-ID: <20050407184917.GA3771@kroah.com>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org> <87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org> <87wtrqtn2n.fsf@coraid.com> <20050329165705.GA31013@infradead.org> <8764yywidw.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8764yywidw.fsf@coraid.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 02:28:59PM -0400, Ed L Cashin wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Tue, Mar 29, 2005 at 11:48:48AM -0500, Ed L Cashin wrote:
> >> I don't know if it matters now that we have udev.  When udev manages
> >> the device nodes it all just works,
> >
> > But most peopel still don't use udev.
> >
> >> If you're saying that it's bad in principal, then that's another
> >> story.  If that's what you mean, then it's a Linux policy issue, and
> >> to follow convention I'd think that we'd need another major number.
> >> That would be like the partitionable md devices, etc.
> >
> > Yes, it's a policy issue.  We don't do this weird config option anywhere
> > else.
> 
> A couple support calls later, I think I've come around to your point
> of view.  This patch isn't needed and may cause confusion.
> 
> Few aoe users really use partitions on their aoe disks, so I can make
> the aoe driver have one minor number per disk as the default to avoid
> the most common problems people encounter.
> 
> Then, aoe users who really need to partition their network disks can
> use the partitionable md driver to "wrap" the aoe disk, like this:
> 
>   mdadm -B -l linear --force -n 1 --auto=mdp /dev/md_p0 /dev/etherd/e7.0
>   fdisk /dev/md_p0

So, which one of the aoe patches listed at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/
do you want me to drop?  This one:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/driver/aoe-AOE_PARTITIONS.patch
?
Or some other one too?

thanks,

greg k-h
