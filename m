Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271091AbTGWFwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 01:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271101AbTGWFwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 01:52:38 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:47631 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271090AbTGWFwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 01:52:37 -0400
Date: Wed, 23 Jul 2003 07:07:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Otto Solares <solca@guug.org>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723070739.A697@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, Otto Solares <solca@guug.org>,
	zaitcev@redhat.com, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722175400.4fe2aa5d.davem@redhat.com>; from davem@redhat.com on Tue, Jul 22, 2003 at 05:54:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 05:54:00PM -0700, David S. Miller wrote:
> No, the problem is that SCSI DMA transfer direction
> macros are defined in terms of PCI ones.  That's all,
> it's a minor issue and probably easily solved.

That's not true, there's not really any SCSI DMA transfer direction
macros anymore, but scsi now uses the generic enum dma_direction directly.

Sparc unfortunately defines the new DMA API in terms of the PCI DMA API
which gets you this mess.

