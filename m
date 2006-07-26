Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWGZKhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWGZKhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGZKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:37:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11659 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932270AbWGZKhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:37:43 -0400
Date: Wed, 26 Jul 2006 13:37:42 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, manfred@colorfullife.com
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
In-Reply-To: <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com>
 <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com>
 <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com>
 <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com>
 <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI>
 <20060726101340.GE9592@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Heiko Carstens wrote:
> It's enough to fix the ARCH_SLAB_MINALIGN problem. But it does _not_ fix the
> ARCH_KMALLOC_MINALIGN problem. s390 currently only uses ARCH_KMALLOC_MINALIGN
> since that should be good enough and it doesn't disable as much debugging
> as ARCH_SLAB_MINALIGN does.
> What exactly isn't clear from the description of the first patch? Or why do
> you consider it bogus?

Now I am confused. What do you mean by "doesn't disable as much debugging 
as ARCH_SLAB_MINALIGN does"? AFAICT, the SLAB_RED_ZONE and SLAB_STORE_USER 
options _require_ BYTES_PER_WORD alignment, so if s390 requires 8 
byte alignment, you can't have them debugging anyhow...

				Pekka
