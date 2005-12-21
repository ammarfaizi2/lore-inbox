Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVLUSRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVLUSRh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVLUSRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:17:37 -0500
Received: from hera.kernel.org ([140.211.167.34]:23269 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932488AbVLUSRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:17:36 -0500
Date: Wed, 21 Dec 2005 16:17:32 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Hellwig <hch@infradead.org>, Dan Aloni <da-x@monatomic.org>,
       Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.x] prevent emulated SCSI hosts from wasting DMA memory
Message-ID: <20051221181732.GC28272@dmt.cnet>
References: <20051130171520.GB15505@localdomain> <200511301933.48668.luke-jr@utopios.org> <20051130210222.GA32431@localdomain> <20051201113610.GG3958@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201113610.GG3958@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 11:36:10AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 30, 2005 at 11:02:23PM +0200, Dan Aloni wrote:
> > On Wed, Nov 30, 2005 at 07:33:47PM +0000, Luke-Jr wrote:
> > > On Wednesday 30 November 2005 17:15, Dan Aloni wrote:
> > > > Emulated scsi hosts don't do DMA, so don't unnecessarily increase
> > > > the SCSI DMA pool.
> > > 
> > > They don't? Recently I learned(?) that apparently using hdparm -d on the 
> > > old /dev/hdX device still worked/applied when using ide-scsi... or do 
> > > "emulated scsi hosts" refer to something else?
> > 
> > Actually by 'do DMA' I meant use the scsi_malloc() interface - which 
> > is mostly used by low level drivers. The IDE drivers allocate their
> > DMA memory outside the SCSI layer. iSCSI hosts for instance, don't 
> > need to cause unnecessary DMA allocations.
> 
> (1) there's no guranteee a driver setting ->emulated can't use scsi_malloc
> (2) 2.4.x is very late in the cycle so there's just no point in putting this
>     in (and in 2.6.x scsi_malloc is gone fortunately)

Agreed - this does not sound like a critical bug fix to me.
