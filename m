Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVCQDoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVCQDoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 22:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVCQDoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 22:44:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261808AbVCQDoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 22:44:15 -0500
Date: Wed, 16 Mar 2005 22:44:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Paul Mackerras <paulus@samba.org>
cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <16952.53719.150647.638710@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.61.0503162243420.23084@chimarrao.boston.redhat.com>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk> <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
 <200503161406.01788.jbarnes@engr.sgi.com> <Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com>
 <16952.53719.150647.638710@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Paul Mackerras wrote:

> > Under Xen, however, the two are different - and the
> > AGPGART really needs to have the physical address ;)
> 
> If Xen is letting the kernel program the GART, you just lost any
> memory isolation between partitions you might have been trying to
> enforce. :)

All the device drivers live in domain 0, so Xen doesn't
need its own set of device drivers.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
