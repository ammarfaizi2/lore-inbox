Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbTGWGNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTGWGNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:13:34 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57103 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271115AbTGWGNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:13:32 -0400
Date: Wed, 23 Jul 2003 07:28:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, solca@guug.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723072836.A932@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, solca@guug.org,
	zaitcev@redhat.com, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722232410.7a37ed4d.davem@redhat.com>; from davem@redhat.com on Tue, Jul 22, 2003 at 11:24:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:24:10PM -0700, David S. Miller wrote:
> Sparc did not do this, the person coding up the new DMA API
> decided it was a good idea to implement the generic version
> this way. :-)
> 
> I think it's rediculious that I have to implement the whole
> new DMA API abstraction thing just to get rid of this PCI
> dependency.
> 
> Why don't we put the enum dma_direction somewhere else?  Some
> linux/foo.h header that doesn't require asm/dma*.h

Putting it into linux/dma-mapping.h is fine with me, but I expect to
see more users of the dma-mapping API soon..
