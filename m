Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWGZT3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWGZT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWGZT3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:29:15 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:60585 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751768AbWGZT3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:29:15 -0400
Message-ID: <44C7C261.6050602@colorfullife.com>
Date: Wed, 26 Jul 2006 21:28:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI> <20060726101340.GE9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI> <20060726105204.GF9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI> <44C7AF31.9000507@colorfullife.com> <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com> <44C7B842.5060606@colorfullife.com> <Pine.LNX.4.64.0607261153220.6896@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607261153220.6896@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>So Redzoning etc will now be diabled regardless even if  
>ARCH_SLAB_MINALIGN is not set but another alignment is given to 
>kmem_cache_alloc?
>  
>
kmem_cache_create().

>So we sacrifice the ability to worsen the performance of slabs by 
>misaligning them for debugging purposes.
>  
>
If a slab user can live with misaligned objects, then he shouldn't set 
align. Thus we do not sacrifice anything.

--
    Manfred
