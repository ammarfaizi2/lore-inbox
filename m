Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbUKVHkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUKVHkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 02:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUKVHj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 02:39:56 -0500
Received: from canuck.infradead.org ([205.233.218.70]:44041 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261963AbUKVHjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 02:39:16 -0500
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
From: David Woodhouse <dwmw2@infradead.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-mtd@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411211932000.3732@xanadu.home>
References: <20041118021538.5764d58c.akpm@osdl.org>
	 <20041118154110.GE4943@stusta.de>
	 <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0411181132440.12260@xanadu.home>
	 <20041118213232.GG4943@stusta.de>
	 <Pine.LNX.4.61.0411181727010.12260@xanadu.home>
	 <20041118232527.GI4943@stusta.de>
	 <Pine.LNX.4.61.0411182041130.12260@xanadu.home>
	 <20041119133500.GF22981@stusta.de>
	 <Pine.LNX.4.61.0411191130190.3732@xanadu.home>
	 <20041121195617.GB13254@stusta.de>
	 <Pine.LNX.4.61.0411211932000.3732@xanadu.home>
Content-Type: text/plain
Date: Mon, 22 Nov 2004 07:38:52 +0000
Message-Id: <1101109132.9988.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-21 at 19:38 -0500, Nicolas Pitre wrote:
> But I continue to disagree with your proposed patch.
> And I'll bet that you will continue to disagree with mine.
> 
> Can we let the MTD maintainer arbitrate on this?

Personally I prefer the #error. People with platforms which _don't_ yet
provide the underlying primitives which the XIP code needs will see the
option, turn it on and work out what they need to do. Otherwise, they'll
continue to be unaware that it even exists. 

I consider that to be more important than the case of someone who turns
it on when they don't actually want it.

-- 
dwmw2

