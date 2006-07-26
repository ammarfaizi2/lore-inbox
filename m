Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbWGZTbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbWGZTbT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbWGZTbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:31:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21915 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751771AbWGZTbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:31:18 -0400
Date: Wed, 26 Jul 2006 12:31:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <44C7C261.6050602@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0607261229430.7132@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
 <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
 <44C7AF31.9000507@colorfullife.com> <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
 <44C7B842.5060606@colorfullife.com> <Pine.LNX.4.64.0607261153220.6896@schroedinger.engr.sgi.com>
 <44C7C261.6050602@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Manfred Spraul wrote:

> > So we sacrifice the ability to worsen the performance of slabs by
> > misaligning them for debugging purposes.
> >  
> If a slab user can live with misaligned objects, then he shouldn't set align.
> Thus we do not sacrifice anything.

A slab user is setting alignment in order to optimize performance not for 
correctness. Most users that I know of can live with misalignments. If 
that would not be the case then this code would never have worked.

