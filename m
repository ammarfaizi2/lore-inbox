Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266325AbUFPVtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUFPVtC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266327AbUFPVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:49:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10942 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266325AbUFPVsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:48:47 -0400
Date: Wed, 16 Jun 2004 17:48:25 -0400
From: Alan Cox <alan@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.orgyy
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040616214825.GA29750@devserv.devel.redhat.com>
References: <20040616210455.GA13385@devserv.devel.redhat.com> <20040616213343.GA20488@infradead.org> <20040616214048.GA27169@devserv.devel.redhat.com> <20040616214257.GA20787@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616214257.GA20787@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 10:42:57PM +0100, Christoph Hellwig wrote:
> > Its something I hope to get rid of eventually. In the meantime the GART
> > define is needed to make it work on AMD64.
> 
> Well, the code is completely wrong.  It must not only go away for AMD64 but
> for all arches.

The hardware and firmware require knowledge of the host memory layout. They
also use it. Right now I can't find a portable way to extract this information.
If you've got any suggestions I'd like to hear them.

Its even worse than it seems too because an IOMMU as in the AMD case changes
the rules in ways the board simply doesn't expect.

Alan

