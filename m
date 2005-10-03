Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbVJCTik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbVJCTik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVJCTik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:38:40 -0400
Received: from amdext4.amd.com ([163.181.251.6]:25807 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932657AbVJCTik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:38:40 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Mon, 3 Oct 2005 13:55:31 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Geode GX/LX support
Message-ID: <20051003195531.GB30975@cosmic.amd.com>
References: <20051003174738.GC29264@cosmic.amd.com>
 <1128366109.26992.27.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1128366109.26992.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5F573B07G1358372-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/05 20:01 +0100, Alan Cox wrote:
> On Llu, 2005-10-03 at 11:47 -0600, Jordan Crouse wrote:
> > +	  - "Geode GX" for AMD Geode GX processors
> >  	  - "Crusoe" for the Transmeta Crusoe series.
> >  	  - "Efficeon" for the Transmeta Efficeon series.
> >  	  - "Winchip-C6" for original IDT Winchip.
> 
> Whats wrong with the existing MGEODEGX1 define (other than it doesn't
> say AMD)

As I mentioned in the previous e-mail, the GEODEGX1 define as it stands
is incorrect - the cache line size should be 16 bytes for the GX1.  The 
GX and LX share a newer core, so it stands, I think that they should have
a different define.

> >  config X86_USE_3DNOW
> >  	bool
> > -	depends on MCYRIXIII || MK7
> > +	depends on MCYRIXIII || MK7 || MGEODE_GX
> >  	default y
> 
> Is this correct - last time I benchmarked it the older GEODE was better
> off using non MMX copies ?

The jury is still out on that.  Certainly, optimizing for i586 architectures
is incorrect, because the pipelining is different then on a Pentium machine
(i586 optimized code is much slower, especially in userland).  I don't have
any solid numbers on the performance of just -mmx or -3dnow, but my gut 
feeling from months of use is that the performance isn't any worse, at least.  
I suppose that I should come with something more solid then a gut feeling, 
though, substantial as my gut may be.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

