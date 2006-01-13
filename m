Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422786AbWAMSKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWAMSKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWAMSKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:10:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39555 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422785AbWAMSKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:10:11 -0500
Date: Fri, 13 Jan 2006 18:10:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Moore, Eric" <Eric.Moore@lsil.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] - pci_ids - adding pci device id support for FC949ES
Message-ID: <20060113181002.GG20718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, "Moore, Eric" <Eric.Moore@lsil.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <F331B95B72AFFB4B87467BE1C8E9CF5F1AA29A@NAMAIL2.ad.lsil.com> <20060113000323.09cbff98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113000323.09cbff98.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 12:03:23AM -0800, Andrew Morton wrote:
> >  --- b/include/linux/pci_ids.h	2006-01-11 19:04:18.000000000 -0700
> >  +++ a/include/linux/pci_ids.h	2006-01-12 14:19:43.000000000 -0700
> >  @@ -181,6 +181,7 @@
> >   #define PCI_DEVICE_ID_LSI_FC929X	0x0626
> >   #define PCI_DEVICE_ID_LSI_FC939X	0x0642
> >   #define PCI_DEVICE_ID_LSI_FC949X	0x0640
> >  +#define PCI_DEVICE_ID_LSI_FC949ES	0x0646
> >   #define PCI_DEVICE_ID_LSI_FC919X	0x0628
> >   #define PCI_DEVICE_ID_NCR_YELLOWFIN	0x0701
> >   #define PCI_DEVICE_ID_LSI_61C102	0x0901
> 
> That doesn't add support - it just adds the ID.  We've apparently decided
> not to keep IDs of devices which the kernel doesn't support.

There's a patch on linux-scsi that adds the actual support.

> Also, there's a plan to stop using pci_ids.h - PCI IDs are supposed to go
> into a driver-private header file.  I guess drivers/scsi/megaraid.h is an
> example.

That's new to me.  In either case a single driver should do one thing
consistantly, and fusion has tons of defines in pci_ids.h already.
