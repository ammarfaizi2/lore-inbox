Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751712AbWCOWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbWCOWNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCOWNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:13:09 -0500
Received: from kanga.kvack.org ([66.96.29.28]:15313 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751712AbWCOWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:13:08 -0500
Date: Wed, 15 Mar 2006 17:07:27 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in "struct resource"
Message-ID: <20060315220727.GF25361@kvack.org>
References: <20060315193114.GA7465@in.ibm.com> <20060315205306.GC25361@kvack.org> <46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org> <20060315211335.GD25361@kvack.org> <m1y7zbe6rn.fsf@ebiederm.dsl.xmission.com> <20060315212841.GE25361@kvack.org> <m13bhje5d1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bhje5d1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 02:59:54PM -0700, Eric W. Biederman wrote:
> Actually now that I think back there are machines with < 4GiB of ram
> with 64bit pci BAR values.  It is more common to have 32bit values BAR
> values and > 4GiB of ram.

Such machines on x86 would have to be compiled with PAE.  Ditto any other 
architecture, as you *have* to be able to represent those physical addresses, 
which requires having page tables that can map them, which requires whatever 
PAE is on the platform.

> Nor do I think struct resource is nearly as important when being
> efficient, as dma_addr_t.  struct resource is only used during
> driver setup which is a very rare event.  A few extra instructions
> there likely will get lost in the noise and most of the will probably
> be removed because they are in an __init section anyway.

Bloat for no good reason is a bad habit to get into.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
