Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUDHAvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 20:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDHAvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 20:51:16 -0400
Received: from ns.suse.de ([195.135.220.2]:27847 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261321AbUDHAvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 20:51:14 -0400
Date: Thu, 8 Apr 2004 02:51:11 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: akpm@osdl.org, mbligh@aracnet.com, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408025111.5f6ee941.ak@suse.de>
In-Reply-To: <20040408002626.GZ26888@dualathlon.random>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<5840000.1081377504@flay>
	<20040408003809.01fc979e.ak@suse.de>
	<20040407155225.14936e8a.akpm@osdl.org>
	<20040408013522.294f0322.ak@suse.de>
	<20040407165639.2198b215.akpm@osdl.org>
	<20040408021448.0dbaa80f.ak@suse.de>
	<20040408002626.GZ26888@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004 02:26:26 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> On Thu, Apr 08, 2004 at 02:14:48AM +0200, Andi Kleen wrote:
> > Eliminate the RB color field or use rb_next() instead of vm_next. First 
> > alternative is cheaper.
> 
> with eliminate I assume you mean to reuse a bit in the vma for that
> (like vma->vm_flags), somewhere the color bit info is needed to make the
> rebalanacing in mmap quick but to still guarantee the max height <= 2 *
> min height.

Yes. Put it either into flags or into the low order bits of a pointer.

-Andi
