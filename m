Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWGZLtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWGZLtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWGZLtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:49:25 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57523 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030275AbWGZLtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:49:24 -0400
Date: Wed, 26 Jul 2006 14:49:23 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Christoph Lameter <clameter@sgi.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com> <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
 <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka J Enberg wrote:
> Note that this will fix the kmem_cache_init() case too. If 
> ARCH_KMALLOC_MINALIGN is greater than BYTES_PER_WORD, we'll disable 
> debugging for those caches. It's obviously ok to have debugging for 
> kmem_cache_init caches too if ARCH_KMALLOC_MINALIGN is greater than or 
> equal to BYTES_PER_WORD.

Eh, meant "if ARCH_KMALLOC_MINALIGN is less than or equal to 
BYTES_PER_WORD" obviously.
