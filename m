Return-Path: <linux-kernel-owner+w=401wt.eu-S932147AbXACWYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXACWYM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXACWYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:24:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55777 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbXACWYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:24:10 -0500
Date: Wed, 3 Jan 2007 14:23:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: James.Smart@Emulex.Com, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 5/5] lpfc : Make Emulex lpfc driver legacy I/O port free
Message-Id: <20070103142349.6f8b0310.akpm@osdl.org>
In-Reply-To: <1167862008.2789.81.camel@mulgrave.il.steeleye.com>
References: <4564051C.3080908@jp.fujitsu.com>
	<4564706E.9060900@emulex.com>
	<1167862008.2789.81.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 16:06:48 -0600
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> On Wed, 2006-11-22 at 10:44 -0500, James Smart wrote:
> > ACK  :)
> > 
> > (I thought this had already gone in a while ago)
> 
> Actually, there seems to be missing infrastructure for this:
> 
>   CC [M]  drivers/scsi/lpfc/lpfc_init.o
> drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_pci_probe_one':
> drivers/scsi/lpfc/lpfc_init.c:1418: warning: implicit declaration of function 'pci_select_bars'
> drivers/scsi/lpfc/lpfc_init.c:1422: warning: implicit declaration of function 'pci_request_selected_regions'
> drivers/scsi/lpfc/lpfc_init.c:1734: warning: implicit declaration of function 'pci_release_selected_regions'

That's here, in Greg's PCI tree:

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-pci/pci-add-selected_regions-funcs.patch

> Is there any ETA on the rest of the infrastructure?
> 

It doesn't look like a bugfix :(
