Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266326AbUFPV6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266326AbUFPV6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUFPV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:58:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:47008 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266326AbUFPV6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:58:35 -0400
Date: Wed, 16 Jun 2004 22:58:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.orgyy
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040616215834.GA21072@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.orgyy
References: <20040616210455.GA13385@devserv.devel.redhat.com> <20040616213343.GA20488@infradead.org> <20040616214048.GA27169@devserv.devel.redhat.com> <20040616214257.GA20787@infradead.org> <20040616214825.GA29750@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616214825.GA29750@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 05:48:25PM -0400, Alan Cox wrote:
> On Wed, Jun 16, 2004 at 10:42:57PM +0100, Christoph Hellwig wrote:
> > > Its something I hope to get rid of eventually. In the meantime the GART
> > > define is needed to make it work on AMD64.
> > 
> > Well, the code is completely wrong.  It must not only go away for AMD64 but
> > for all arches.
> 
> The hardware and firmware require knowledge of the host memory layout. They
> also use it. Right now I can't find a portable way to extract this information.
> If you've got any suggestions I'd like to hear them.
> 
> Its even worse than it seems too because an IOMMU as in the AMD case changes
> the rules in ways the board simply doesn't expect.

Yikes.  This looked like they usual use 32bit dma descriptors if not
enough memory hacks to me.  If aacraid is that royally fucked we should
probably add CONFIG_X86 to it.

Never underestimate the braindamage that can happen at Adaptec..

