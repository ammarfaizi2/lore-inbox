Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbTGWGtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271145AbTGWGtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:49:51 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:19472 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271107AbTGWGtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:49:50 -0400
Date: Wed, 23 Jul 2003 08:04:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Otto Solares <solca@guug.org>
Cc: "David S. Miller" <davem@redhat.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723080454.B5245@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Otto Solares <solca@guug.org>, "David S. Miller" <davem@redhat.com>,
	zaitcev@redhat.com, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com> <20030723064311.GE30174@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030723064311.GE30174@guug.org>; from solca@guug.org on Wed, Jul 23, 2003 at 12:43:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 12:43:11AM -0600, Otto Solares wrote:
> I originally though the whole idea was to remove the PCI dependency.

There is no pci depency in the scsi core or drivers.  The only
problem is that the dma-mapping.h implementation used by sparc
imposes an artifical PCI depency that needs to be removed.

If you want to help fix asm-generic/dma-mapping.h to be noops
if !CONFIG_PCI or even better make it always noops and add an
asm-generic/dma-mapping-in-terms-of-pci.h for those who want
them to map to PCI.

