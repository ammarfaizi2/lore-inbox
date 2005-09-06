Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVIFVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVIFVGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbVIFVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:06:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750941AbVIFVGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:06:12 -0400
Date: Tue, 6 Sep 2005 14:04:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch 2.6.13 2/2] 3c59x: add option for using memory-mapped
 PCI I/O resources
Message-Id: <20050906140414.40b65253.akpm@osdl.org>
In-Reply-To: <20050906205429.GA19319@infradead.org>
References: <20050906204147.GC20145@tuxdriver.com>
	<20050906204400.GD20145@tuxdriver.com>
	<20050906205429.GA19319@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 06, 2005 at 04:44:00PM -0400, John W. Linville wrote:
> > Add module option to enable 3c59x driver to use memory-mapped PCI I/O
> > resources.  This may improve performance for those devices so equipped.
> > 
> > Add "use_mmio=1" to the 3c59x module options in order to enable this
> > functionality.
> 
> I'm not sure a module option makes sense for this setting, except maybe
> as a debugging aid.  You should rather have a flag in the PCI IDs private
> data that can be used to enable mmio for those cards that support it.

I guess it's OK for the initial testing.  Plus we should make the new
feature default to "on" during initial public testing.  I'll make that
change.

