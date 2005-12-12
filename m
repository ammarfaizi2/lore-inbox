Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVLLVbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVLLVbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVLLVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:31:12 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:16617 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932137AbVLLVbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:31:09 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH]: Re: qla1280.c broken on SGI visws, PCI coherency problem
Date: Mon, 12 Dec 2005 13:31:06 -0800
User-Agent: KMail/1.9
Cc: Michael Reed <mdr@sgi.com>, Michael Joosten <michael.joosten@c-lab.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4399D6EB.4080603@c-lab.de> <439DE50B.90007@sgi.com> <20051212212427.GA9139@infradead.org>
In-Reply-To: <20051212212427.GA9139@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512121331.06467.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 12, 2005 1:24 pm, Christoph Hellwig wrote:
> While we're at it, does anyone know whyt the ioread* interface doesn't
> provide the _relaxed version?  I'd really love to switch qla1280 over
> to it given that it needs to support both mmio and pio.

Back when ioread was being discussed on linux-arch, I remember Linus 
saying that perhaps *all* ioreads should be relaxed wrt. DMA (unlike the 
current mmio accessor functions), but I'm not sure if those are the 
semantics we finally settled on.  If not, an ioread*_relaxed would be 
nice to add for the platforms that can support it.

Jesse
