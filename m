Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUHFPEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUHFPEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268075AbUHFPEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:04:40 -0400
Received: from colin2.muc.de ([193.149.48.15]:25097 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268077AbUHFPER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:04:17 -0400
Date: 6 Aug 2004 17:04:16 +0200
Date: Fri, 6 Aug 2004 17:04:16 +0200
From: Andi Kleen <ak@muc.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: "David S. Miller" <davem@redhat.com>, yoshfuji@linux-ipv6.org,
       jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040806150416.GA90652@muc.de>
References: <20040804191850.GA19224@havoc.gtf.org> <20040804.165113.06226042.yoshfuji@linux-ipv6.org> <20040804205837.6fda9a50.davem@redhat.com> <200408060303.40261.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408060303.40261.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Somewhere I got the idea that if a structure is declared with attribute 
> PACKED, gcc will generate alignment-independent code (e.g., access each field 
> byte by byte) on alignment-restricted architectures.  So if what I imagine 
> about gcc is true, what issues remain?  These structs have to be declared 
> packed anyway and with fixed field sizes, or the layout will vary across 
> architectures.

With packed things should be fine for x86-64/i386. However it may 
generate bad code for other architectures. 

-Andi
