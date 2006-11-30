Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936427AbWK3OY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936427AbWK3OY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 09:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936428AbWK3OY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 09:24:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43461 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936427AbWK3OY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 09:24:57 -0500
Date: Thu, 30 Nov 2006 14:24:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@qumranet.com>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1/38] KVM: Create kvm-intel.ko module
Message-ID: <20061130142435.GA13372@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Avi Kivity <avi@qumranet.com>,
	kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com> <20061127121136.DC69A25015E@cleopatra.q> <20061127123606.GA11825@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127123606.GA11825@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 01:36:06PM +0100, Ingo Molnar wrote:
> 
> * Avi Kivity <avi@qumranet.com> wrote:
> 
> > --- linux-2.6.orig/drivers/kvm/kvm.h
> > +++ linux-2.6/drivers/kvm/kvm.h
> 
> please move this from drivers/kvm/ to kernel/kvm/ [or even into a 
> toplevel kvm/ directory] - KVM is not a "driver", KVM enhances the core 
> Linux kernel with hypervisor functionality.

Actually it's exactly a driver.  It's a character driver that exposes
the virtualization features of modern x86 hardware.  Pretty similar to
things like the msr or mtrr driver that expose cpu features as character
drivers aswell.

