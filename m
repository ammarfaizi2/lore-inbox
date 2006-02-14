Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWBNVYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWBNVYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422685AbWBNVYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:24:44 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:51830 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1422795AbWBNVYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:24:43 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
	<adaslqlu76f.fsf@cisco.com> <20060214200340.GN12822@parisc-linux.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 13:24:41 -0800
In-Reply-To: <20060214200340.GN12822@parisc-linux.org> (Matthew Wilcox's
 message of "Tue, 14 Feb 2006 13:03:40 -0700")
Message-ID: <adahd71tyzq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 14 Feb 2006 21:24:41.0624 (UTC) FILETIME=[1150A980:01C631AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Michael's patch does this:
 > 
 > @@ -347,6 +347,7 @@ pci_alloc_child_bus(struct pci_bus *pare
 >         child->parent = parent;
 >         child->ops = parent->ops;
 >         child->sysdata = parent->sysdata;
 > +       child->bus_flags = parent->bus_flags;
 >         child->bridge = get_device(&bridge->dev);
 > 
 >         child->class_dev.class = &pcibus_class;

Sorry, I missed that.  Yes, that should work.

 - R.
