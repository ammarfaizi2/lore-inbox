Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUEOUuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUEOUuA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 16:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUEOUuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 16:50:00 -0400
Received: from colin2.muc.de ([193.149.48.15]:53516 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264117AbUEOUt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 16:49:59 -0400
Date: 15 May 2004 22:49:57 +0200
Date: Sat, 15 May 2004 22:49:57 +0200
From: Andi Kleen <ak@muc.de>
To: John Reiser <jreiser@BitWagon.com>
Cc: Andi Kleen <ak@muc.de>, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Message-ID: <20040515204957.GB37274@colin2.muc.de>
References: <200405151442.i4FEgkjY001401@harpo.it.uu.se> <20040515191643.GA5748@colin2.muc.de> <40A68056.6090606@BitWagon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A68056.6090606@BitWagon.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want the kernel to avoid every delay that can be avoided.  Do not force

There are a lot of other more frutiful targets I would focus my 
attention then.  e.g. you could get rid of __SLOW_DOWN_IO on modern 
machines which hits all the time and is a *lot* slower than even hundreds 
of pipeline flushes. Or of all the mdelays in driver code like IDE.

> a pipeline flush for speculative rdtsc.  Besides those 20-30 cycles

But how useful is the "work" when it results in wrong answers? 

Speculative RDTSC is not a theoretical problem, it has actually
caused problems in practice in other codes by making CPU timestamps
non monotonic.

-Andi
