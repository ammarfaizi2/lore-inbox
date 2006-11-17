Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933647AbWKQPGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933647AbWKQPGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 10:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933641AbWKQPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 10:06:21 -0500
Received: from zakalwe.fi ([80.83.5.154]:20944 "EHLO zakalwe.fi")
	by vger.kernel.org with ESMTP id S932068AbWKQPGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 10:06:20 -0500
Date: Fri, 17 Nov 2006 17:06:12 +0200
From: Heikki Orsila <shd@zakalwe.fi>
To: Peer Chen <pchen@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Prakash Punnoor <prakash@punnoor.de>, Andrew Morton <akpm@osdl.org>,
       jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Message-ID: <20061117150612.GC12227@zakalwe.fi>
References: <15F501D1A78BD343BE8F4D8DB854566B0CEB90E0@hkemmail01.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0CEB90E0@hkemmail01.nvidia.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:36:37PM +0800, Peer Chen wrote:
> I didn't get any comment from you guys for new patch, does someone take
> care this patch, do we still need some modification upon it? Or do we
> need re-submit it in other thread?

One small change suggestion:

> +static inline bool nv_sgpio_capable(const struct pci_device_id *ent)         
> +{                                                                            
> +     if (ent->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2)             
> +             return 1;                                                       
> +     else                                                                    
> +             return 0;                                                       
> +}                          

Make it shorter ->

	return ent->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2;

 - Heikki
