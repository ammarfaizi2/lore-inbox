Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTJaNJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTJaNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:09:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263298AbTJaNJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:09:45 -0500
Date: Fri, 31 Oct 2003 13:09:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org, garloff@suse.de, matthias.andree@gmx.de
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031031130935.D4556@flint.arm.linux.org.uk>
Mail-Followup-To: Guennadi Liakhovetski <gl@dsa-ac.de>,
	Christoph Hellwig <hch@infradead.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org, garloff@suse.de,
	matthias.andree@gmx.de
References: <20031031114616.A16435@infradead.org> <Pine.LNX.4.33.0310311254530.5914-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0310311254530.5914-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Fri, Oct 31, 2003 at 01:19:56PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 01:19:56PM +0100, Guennadi Liakhovetski wrote:
> > Oh.  What driver did you find this construct in?
> 
> grep... (maybe not all of them are real hits, but, most of them do
> certainly look very much like what I've done). BTW, I also saw arrays of
> cards in some drvers, which also doesn't correspond to your suggestions:
> 
> drivers/scsi/arm/scsi.h-41-		SCp->ptr = (char *)
> drivers/scsi/arm/scsi.h:42:			 (page_address(SCp->buffer->page) +
> drivers/scsi/arm/scsi.h-43-			  SCp->buffer->offset);
> --
> drivers/scsi/arm/scsi.h-79-		SCpnt->SCp.ptr = (char *)
> drivers/scsi/arm/scsi.h:80:			 (page_address(SCpnt->SCp.buffer->page) +
> drivers/scsi/arm/scsi.h-81-			  SCpnt->SCp.buffer->offset);

The drivers which use this will never be used on highmem-capable machines.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
