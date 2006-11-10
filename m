Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945996AbWKJG5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945996AbWKJG5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 01:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945991AbWKJG5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 01:57:24 -0500
Received: from cantor2.suse.de ([195.135.220.15]:32989 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1945998AbWKJG5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 01:57:23 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
Date: Fri, 10 Nov 2006 07:56:59 +0100
User-Agent: KMail/1.9.5
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Chua <jeff.chua.linux@gmail.com>,
       Matthew Wilcox <matthew@wil.cx>, Aaron Durbin <adurbin@google.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com> <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org> <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611100757.00203.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What a piece of crap. 
> 
> Andi, I'm getting really upset about this kind of thing. You've been very 
> much not careful about MMCFG in general, and are allowing total crap to go 
> into the kernel, without any thought. Just "testing" something isn't good 
> enough, it needs to be thought out.

Sorry, probably should have read the patch more carefully.

I think I agreed with the high level idea but didn't double check
the details.

> 
> I'm going to revert that totally bogus commit that added that broken 
> "pci_mmcfg_insert_resources()" function. It could be done right, but doing 
> it right would require that the function 

Ok fine by me.

> We really should stop using MMCONFIG entirely, until we have a 

Hmm, for .19 at least you mean? 

Entirely stopping it would break the x86 macs minis again I think.
But we can make it "only use if type 1 doesn't work" 

I'm sure some people will be upset again if we don't use it.
Perhaps there are really users who want to use the PCI-E error handling
for example.

> per-southbridge true knowledge of what the real decoding is. The BIOS 
> tables for this are simply too damn unreliable.

My hopes for that are on Vista. Perhaps use a DMI year test again
(>= 2007) and only white lists for older boards.

-Andi
 
