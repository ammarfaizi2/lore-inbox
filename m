Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVLQUrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVLQUrf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVLQUrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:47:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964895AbVLQUre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:47:34 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: rol@witbe.net
Cc: "'Kyle Moffett'" <mrmacman_g4@mac.com>, "'Andi Kleen'" <ak@suse.de>,
       "'Adrian Bunk'" <bunk@stusta.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512172023.jBHKNiD15808@tag.witbe.net>
References: <200512172023.jBHKNiD15808@tag.witbe.net>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 21:47:11 +0100
Message-Id: <1134852432.2997.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 21:23 +0100, Paul Rolland wrote:
> Hello,
> 
> > One comment on x86-64 vs. x86:  There are restrictions on where in  
> > memory your process stacks can be located on a 32-bit 
> > platform.  They  
> > need to reside in lowmem, which means under certain circumstances  
> > your lowmem can get too fragmented to create new processes even  
> > though you still have a lot of available RAM.
> 
> But where does these restrictions come from ? As far as I know, stack
> is referenced to by SS:ESP registers, and nothing in the x86 architecture
> prevents them from pointing outside of lowmem... Isn't this simply a
> Linux design restriction ?

lowmem is a linux design restriction; only lowmem is directly
addressable.

(also remember that you can have 36 bits of physical ram, but only 32
bit in a pointer, so even if lowmem wasn't 870Mb itd be limited to 4Gb)

