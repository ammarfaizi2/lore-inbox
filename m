Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbTCTTRl>; Thu, 20 Mar 2003 14:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbTCTTRl>; Thu, 20 Mar 2003 14:17:41 -0500
Received: from havoc.daloft.com ([64.213.145.173]:64212 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261765AbTCTTRk>;
	Thu, 20 Mar 2003 14:17:40 -0500
Date: Thu, 20 Mar 2003 14:28:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Jes Sorensen <jes@wildopensource.com>, Jeff Garzik <garzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <20030320192836.GD8256@gtf.org>
References: <14240000.1048146629@[10.10.2.4]> <m365qenioq.fsf@trained-monkey.org> <20030320160440.A14435@infradead.org> <9590000.1048176717@[10.10.2.4]> <20030320192020.GB3315@kroah.com> <413920000.1048187623@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413920000.1048187623@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 11:13:43AM -0800, Martin J. Bligh wrote:
> Hmmm ... so we're going to get a compiler warning for every hotpluggable
> driver?

Only for the ones that do not actually use the module_device_table,
which is an unusual case.

Adam Richter(sp?) went through and added PCI module_device_tables to
drivers which do not use the PCI API.  From the programmer's standpoint
this looks like dead code -- but it's actually very useful, because it
exports the PCI ids to userspace in
/lib/modules/`uname -r`/modules.pcimap, where installers, hardware
configurators, and other tools pick up the data and do something useful
with it.

	Jeff



