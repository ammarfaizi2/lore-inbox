Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbTHJNy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269512AbTHJNy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:54:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53000 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269334AbTHJNy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:54:26 -0400
Date: Sun, 10 Aug 2003 14:54:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-ID: <20030810145403.A32508@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	davem@redhat.com, linux-kernel@vger.kernel.org
References: <20030810013041.679ddc4c.davem@redhat.com> <20030810090556.GY31810@waste.org> <20030810020444.48cb740b.davem@redhat.com> <20030810.201009.77128484.yoshfuji@linux-ipv6.org> <20030810123148.A10435@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810123148.A10435@infradead.org>; from hch@infradead.org on Sun, Aug 10, 2003 at 12:31:48PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 12:31:48PM +0100, Christoph Hellwig wrote:
> > --- linux-2.6/drivers/scsi/arm/scsi.h	19 May 2003 17:48:30 -0000	1.2
> > +++ linux-2.6/drivers/scsi/arm/scsi.h	10 Aug 2003 09:30:33 -0000
> > @@ -23,7 +23,7 @@
> >  	BUG_ON(bufs + 1 > max);
> >  
> >  	sg->page   = virt_to_page(SCp->ptr);
> > -	sg->offset = ((unsigned int)SCp->ptr) & ~PAGE_MASK;
> > +	sg->offset = virt_to_pageoff(SCp->ptr);
> >  	sg->length = SCp->this_residual;
> 
> Dito.

No.  DMA mapping is handled later.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

