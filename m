Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDHA04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUDHA0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:26:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9421
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261389AbUDHA02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:26:28 -0400
Date: Thu, 8 Apr 2004 02:26:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mbligh@aracnet.com, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <20040408002626.GZ26888@dualathlon.random>
References: <1081373058.9061.16.camel@arrakis> <20040407145130.4b1bdf3e.akpm@osdl.org> <5840000.1081377504@flay> <20040408003809.01fc979e.ak@suse.de> <20040407155225.14936e8a.akpm@osdl.org> <20040408013522.294f0322.ak@suse.de> <20040407165639.2198b215.akpm@osdl.org> <20040408021448.0dbaa80f.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408021448.0dbaa80f.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 02:14:48AM +0200, Andi Kleen wrote:
> Eliminate the RB color field or use rb_next() instead of vm_next. First 
> alternative is cheaper.

with eliminate I assume you mean to reuse a bit in the vma for that
(like vma->vm_flags), somewhere the color bit info is needed to make the
rebalanacing in mmap quick but to still guarantee the max height <= 2 *
min height.
