Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTD1RBi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbTD1RBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:01:38 -0400
Received: from ns.suse.de ([213.95.15.193]:28935 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261199AbTD1RBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:01:37 -0400
Date: Mon, 28 Apr 2003 19:13:53 +0200
From: Andi Kleen <ak@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428171353.GB1068@Wotan.suse.de>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD5D90.7010101@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cool. Sorry to be pestering about the 64-bit limits, but can we really
> use 2^64 bytes of memory on ia64/ppc64/x86-64 etc.? (AFAIK, 64-bit
> arches don't suffer from a small ZONE_LOWMEM.)

No. The hardware have far smaller physical limits. 

Current AMD64 CPUs are limited to 40bit physical, 48bit virtal
(the virtual limit per process in the current Linux kernel is 39bits) 

Itanium 2 afaik support a bit more 50bits (51 or 52, I forgot) physical,
probably more virtual.

Other 64bit architectures are somewhere inbetween.

The actual limit in the machines is even less. You will have a hard 
time to find an affordable machine (64bit or not) with more than 8 DIMM 
slots. That's 16GB Max with 2GB DIMMs.

-Andi

