Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWCUHMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWCUHMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWCUHMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:12:14 -0500
Received: from mtaout2.012.net.il ([84.95.2.4]:9417 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S932280AbWCUHMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:12:12 -0500
Date: Tue, 21 Mar 2006 09:11:41 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: nommu_map_sg: overflow with ata_piix?
In-reply-to: <adaoe00a3my.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <20060321071141.GB25444@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <adawteoa9pc.fsf@cisco.com> <adaoe00a3my.fsf@cisco.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 07:16:37PM -0800, Roland Dreier wrote:
> > nommu_map_sg: overflow 11b8a9000+4096 of device mask ffffffff
> 
> Never mind, I'm (sort of) an idiot.  The kernel that complained like
> that had CONFIG_GART_IOMMU=n -- I foolishly thought, "I have a Xeon,
> which can't do GART IOMMU, so I don't need that option."  I didn't
> realize that it also enables swiotlb.  Once I read the help text I was
> OK.

In theory it should be possible to turn just swiotlb on, but at the
moment it requires gart due to the way pci-dma is structured. If
someone is looking for a little side project, this could be a good
one.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

