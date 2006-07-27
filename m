Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWG0FrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWG0FrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 01:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWG0FrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 01:47:18 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42641 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751801AbWG0FrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 01:47:17 -0400
Date: Thu, 27 Jul 2006 08:47:16 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <Pine.LNX.4.58.0607270823140.28805@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0607270844440.28990@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
 <20060726105204.GF9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI>
 <44C7AF31.9000507@colorfullife.com> <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
 <44C7B842.5060606@colorfullife.com> <Pine.LNX.4.64.0607261153220.6896@schroedinger.engr.sgi.com>
 <44C7C261.6050602@colorfullife.com> <Pine.LNX.4.64.0607261229430.7132@schroedinger.engr.sgi.com>
 <44C7C46C.4090201@colorfullife.com> <Pine.LNX.4.64.0607261239170.7520@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607270823140.28805@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Pekka J Enberg wrote:
> Yes and that's what we have been saying all along. When you want 
> performance, you use SLAB_HWCACHE_ALIGN and let the allocator do its job. 
> I don't see much point from API point of view for the caller to explicitly 
> ask for a given alignment and then in addition pass a 'yes I really meant' 
> flag (SLAB_DEBUG_OVERRIDE).

Btw, /proc/slabinfo for UML with defconfig reveals change for only one 
cache with my patch applied. The 'dquot' cache is created by dquot_init in 
fs/dquot.c and doesn't really seem to need the alignment for anything...

				Pekka
