Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUIAE1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUIAE1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUIAE1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:27:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:41859 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268135AbUIAE1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:27:22 -0400
Subject: Re: page fault scalability patch final : i386 tested, x86_64
	support added
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, Paul Mackerras <paulus@samba.org>,
       ak@muc.de, davem@davemloft.net, Andi Kleen <ak@suse.de>,
       wli@holomorphy.com, "David S. Miller" <davem@redhat.com>,
       raybry@sgi.com, manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>, vrajesh@umich.edu,
       hugh@veritas.com
In-Reply-To: <20040827223954.7d021aac.akpm@osdl.org>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	 <20040816143903.GY11200@holomorphy.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	 <B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	 <Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	 <20040827233602.GB1024@wotan.suse.de>
	 <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	 <20040827172337.638275c3.davem@davemloft.net>
	 <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de>
	 <20040827183940.33b38bc2.akpm@osdl.org>
	 <16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	 <20040827204241.25da512b.akpm@osdl.org>
	 <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
	 <20040827223954.7d021aac.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1094012028.6539.320.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 14:13:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 15:39, Andrew Morton wrote:

> atomic64_t already appears to be implemented on alpha, ia64, mips, s390 and
> sparc64.
> 
> As I said - for both these applications we need a new type which is
> atomic64_t on 64-bit and atomic_t on 32-bit.

Implementing it on ppc64 is trivial. I'd vote for atomic_long_t though
that is either 32 bits on 32 bits archs or 64 bits on 64 bits arch, as
it would be a real pain (spinlock & all) to get a 64 bits atomic on
ppc32

Ben.

