Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWG0EYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWG0EYk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 00:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWG0EYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 00:24:40 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9144 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751260AbWG0EYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 00:24:39 -0400
Date: Thu, 27 Jul 2006 07:24:38 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Manfred Spraul <manfred@colorfullife.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <Pine.LNX.4.64.0607261229430.7132@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0607270720400.28514@sbz-30.cs.Helsinki.FI>
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
 <44C7C261.6050602@colorfullife.com> <Pine.LNX.4.64.0607261229430.7132@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Christoph Lameter wrote:
> A slab user is setting alignment in order to optimize performance not for 
> correctness. Most users that I know of can live with misalignments. If 
> that would not be the case then this code would never have worked.

No, caller and architecture mandated alignment is set for correctness. The 
slab allocator can already optimize for performance on its own 
(SLAB_HWCACHE_ALIGN).

				Pekka
