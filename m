Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUFWRBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUFWRBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUFWRBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:01:08 -0400
Received: from fmr05.intel.com ([134.134.136.6]:7907 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S266578AbUFWRA4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:00:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]2.6.7 MSI-X Update
Date: Wed, 23 Jun 2004 09:58:50 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E5AB3@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]2.6.7 MSI-X Update
Thread-Index: AcRYwmf4u2lU6ZiXSh23inY3QDd0twAf/Kgg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>
Cc: <ak@muc.de>, <akpm@osdl.org>, <greg@kroah.com>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <zwane@linuxpower.ca>,
       <eli@mellanox.co.il>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 23 Jun 2004 16:58:51.0617 (UTC) FILETIME=[5C1AFD10:01C45943]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 22, 2004 Roland Dreier wrote: 
>This looks good, a definite improvement over what's currently in the
>kernel.  I do have one question about the whole msi.c file (and this
>applies to the code that's already in the tree, too).  Why is config
>space being accessed via calls like
>
>	dev->bus->ops->read(dev->bus, dev->devfn, ... )
>
>instead of just calling
>
>        pci_read_config_word(dev, ... )
>
>The only difference seems to be that MSI is bypassing the locking in
>access.c.  Is there some reason for this?

I think that the locking in access.c is not necessary. But I agree 
with you that using pci_read_config_word() would be cleaner. 

Thanks,
Long


