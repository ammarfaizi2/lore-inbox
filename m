Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVAGX2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVAGX2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVAGXZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:25:51 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:47120 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261736AbVAGXY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:24:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6] cciss typo fix
Date: Fri, 7 Jan 2005 17:24:21 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0185@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6] cciss typo fix
Thread-Index: AcT1D1/RxvRJmFYETK2KJOtSrzVGdQAAGJ2A
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 07 Jan 2005 23:24:22.0464 (UTC) FILETIME=[04F4A400:01C4F510]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
> 
> 
> On Fri, 2005-01-07 at 17:01 -0600, mike.miller@hp.com wrote:
> > -		*total_size = be32_to_cpu(*((__be32 *) 
> &buf->total_size[0]))+1;
> > -		*block_size = be32_to_cpu(*((__be32 *) 
> &buf->block_size[0]));
> > +		*total_size = be32_to_cpu(*((__u32 *) 
> &buf->total_size[0]))+1;
> > +		*block_size = be32_to_cpu(*((__u32 *) 
> &buf->block_size[0]));
> 
> I don't think that's a typo.  It was introduced by this patch:
> 
> ChangeSet 1.1988.24.79 2004/10/06 07:55:02 viro@www.linux.org.uk
>   [PATCH] cciss endianness and iomem annotations
>  
> The idea being that BE and LE numbers should be annotated differently,
> so the __be32 annotations look correct to me.  I think sparse 
> will warn
> if you make this change.

Hmmm, SuSE complained that __be32 was not defined in the kernel. Any other thoughts, anyone?

mikem
