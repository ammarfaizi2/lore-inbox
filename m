Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbTIHRJF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTIHRJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:09:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38799 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263247AbTIHRJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:09:02 -0400
Date: Mon, 8 Sep 2003 18:07:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       peter_daum@t-online.de
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Message-ID: <20030908170751.GB27097@mail.jlokier.co.uk>
References: <3F5B96C3.1060706@colorfullife.com> <20030908142046.GA28062@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908142046.GA28062@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> > Why requires? On x86, the cpu caches are fully coherent. A too small L1 
> > cache shift results in false sharing on SMP, but it shouldn't cause the 
> > described problems.
> >...
> 
> Thanks for the correction, I falsely thought CONFIG_X86_L1_CACHE_SHIFT 
> does something different than it does.

Were there any changes in the kernel to do with PCI MWI settings?

(MWI == memory write and invalidate)

If MWI is set incorrectly, I think PCI DMA is capable of breaking x86
cache coherence.

-- Jamie

