Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753534AbWKCVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534AbWKCVJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753535AbWKCVJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 16:09:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:30947 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753534AbWKCVJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 16:09:46 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs =?utf-8?q?for=09paravirtualizing_critical?= operations
Date: Fri, 3 Nov 2006 22:09:40 +0100
User-Agent: KMail/1.9.5
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20061029024504.760769000@sous-sol.org> <200611030356.54074.ak@suse.de> <454BA7F7.8030205@vmware.com>
In-Reply-To: <454BA7F7.8030205@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611032209.40235.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Sounds like desc.h got reordered.  Somewhere, there was a broken patch 
> once that did this, I thought we fixed that.

I think I got Rusty's latest patches that I found in my mailbox.

I haven't looked at desc.h, but at least processor.h ordering was totally
b0rken (e.g. #define __cpuid native_cpuid was after several uses). I fixed
that to make at least the CONFIG_PARAVIRT not set case compile.

I can't see how this ever worked either.

Haven't attempted the CONFIG_PARAVIRT case which apparently needs more work
(it is currently marked CONFIG_BROKEN) 

Can someone double check this is the correct patchkit?

ftp://ftp.frstfloor.org/pub/ak/x86_64/quilt/patches/paravirt*

-Andi


