Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266321AbUFPVoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266321AbUFPVoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUFPVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:44:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:31904 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266321AbUFPVnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:43:01 -0400
Date: Wed, 16 Jun 2004 22:42:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.orgy
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040616214257.GA20787@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.orgy
References: <20040616210455.GA13385@devserv.devel.redhat.com> <20040616213343.GA20488@infradead.org> <20040616214048.GA27169@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616214048.GA27169@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 05:40:48PM -0400, Alan Cox wrote:
> > Looks mostly good except for the GART iommu ifdef.  That code is bogus for
> > almost everything but a plain PC and should just be killed.
> 
> There are lots of problems with the PC centric view of the world some
> aacraid hardware has.  At the moment I'm still working on trying to understand
> the rules and I'll need to talk to Mark some more. I've also got a third
> party trace suggesting a request for low DMA memory came in through the
> gart which is above the address in the mask to look at.
> 
> Its something I hope to get rid of eventually. In the meantime the GART
> define is needed to make it work on AMD64.

Well, the code is completely wrong.  It must not only go away for AMD64 but
for all arches.

