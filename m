Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVCQN4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVCQN4T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 08:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVCQN4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 08:56:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15799 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263070AbVCQN4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 08:56:16 -0500
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       riel@redhat.com, Ian.Pratt@cl.cam.ac.uk, kurt@garloff.de,
       Christian.Limpach@cl.cam.ac.uk
In-Reply-To: <16953.20279.77584.501222@cargo.ozlabs.ibm.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
	 <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
	 <200503161406.01788.jbarnes@engr.sgi.com>
	 <29ab1884ee5724e9efcfe43f14d13376@cl.cam.ac.uk>
	 <16953.20279.77584.501222@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111067594.1213.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Mar 2005 13:53:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-03-17 at 09:34, Paul Mackerras wrote:
> This code needs real physical addresses, which are not the same things
> as bus addresses.  

Not always. The code needs platform specific goodies. We've only never
been burned so far because there isn't a box with an IOMMU and AGPGART
where one maps through the other.

It's probably simplest to have phys_to_agp/agp_to_phys therefore ?

Alan

