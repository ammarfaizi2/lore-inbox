Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWHCCp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHCCp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWHCCp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:45:59 -0400
Received: from ns.suse.de ([195.135.220.2]:36820 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750858AbWHCCp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:45:59 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 04:45:38 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, akpm@osdl.org,
       xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <44D144EC.3000205@goop.org> <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030445.38189.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thats a good goal but what about the rest of us who have to maintain 
> additional forms of bit operations for all architectures. How much is this 
> burden?

I don't think it's that big an issue because most architectures either
use always locked bitops already or don't need them because they don't do
SMP.

So it will be fine with just a asm-generic header that defines them
to the normal bitops. Not much burden.

-Andi
