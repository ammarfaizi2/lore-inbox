Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVC2QZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVC2QZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVC2QZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:25:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54185 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261166AbVC2QZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:25:07 -0500
Date: Tue, 29 Mar 2005 17:25:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
Message-ID: <20050329162506.GA30401@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ed L Cashin <ecashin@coraid.com>, linux-kernel@vger.kernel.org,
	Greg K-H <greg@kroah.com>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org> <87hdiuv3lz.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdiuv3lz.fsf@coraid.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:06:16AM -0500, Ed L Cashin wrote:
> >
> > NACK.  this changes devices nodes based on a compile-time option.  
> 
> I'm not sure I follow.  This configuration option sets the number of
> partitions per device in the driver.  It doesn't create device nodes.
> 
> If the user has udev, then the device nodes are created correctly (on
> Fedora Core 3), so that if the driver is configured with 1 partition
> per device, the minor numbers for the disks are low.  
> 
> The folks I've talked to who aren't using udev but want one partition
> per device already know that they have to re-create their device
> files.

It changes a kernel ABI, so people that have different config options
set can't use the same userland.  It's a really big no-go.

