Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVH3WjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVH3WjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVH3WjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:39:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60847 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932218AbVH3WjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:39:18 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: John Rose <johnrose@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>,
       External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <17171.58403.920889.62559@cargo.ozlabs.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	 <20050825161325.GG25174@austin.ibm.com>
	 <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
	 <20050829160915.GD12618@austin.ibm.com>
	 <17171.58403.920889.62559@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1125441190.27140.13.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Aug 2005 17:33:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul-

> I'm suggesting that the rpaphp code has a struct pci_driver whose
> id_table and probe function are such that it will claim the EADS
> bridges.  (It would probably be best to match on vendor=IBM and
> class=PCI-PCI bridge and let the probe function figure out which of
> the bridges it gets asked about are actually EADS bridges.)

Wouldn't this leave out hotplug-capable adapters who have direct PHB
parents, since these parent PHBs don't have pci_devs?  Thoughts?

Thanks-
John

