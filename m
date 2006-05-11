Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWEKDIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWEKDIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 23:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWEKDIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 23:08:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:27882 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965109AbWEKDIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 23:08:50 -0400
Subject: Re: [PATCH] add slab_is_available() routine for boot code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       penberg@cs.Helsinki.FI, clameter@sgi.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060510230054.GA11214@w-mikek2.ibm.com>
References: <20060510205543.GI3198@w-mikek2.ibm.com>
	 <20060510155026.173c57a1.akpm@osdl.org>
	 <20060510230054.GA11214@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Thu, 11 May 2006 13:07:52 +1000
Message-Id: <1147316872.30380.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'll let Arnd answer.  He ran into this when doing some Cell work.  Not
> sure where in the development cycle the code is that exposes this bug.

I want that too for some other unrelated patches :) I want request_irq()
to use alloc_bootmem when slab is not available so that some low level
arch irqs can be requested at init_IRQ() time.

(Typically IRQs for cascaded controllers). We currently define
statically irqaction structures for them and call setup_irq() on them,
this is gross :)

Cheers,
Ben.

