Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTEQAOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTEQAOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 20:14:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264624AbTEQAOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 20:14:47 -0400
Subject: Re: Race between vmtruncate and mapped areas?
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030515231714.GL1429@dualathlon.random>
References: <20030514103421.197f177a.akpm@digeo.com>
	 <82240000.1052934152@baldur.austin.ibm.com>
	 <20030515004915.GR1429@dualathlon.random>
	 <20030515013245.58bcaf8f.akpm@digeo.com>
	 <20030515085519.GV1429@dualathlon.random>
	 <20030515022000.0eb9db29.akpm@digeo.com>
	 <20030515094041.GA1429@dualathlon.random>
	 <1053016706.2693.10.camel@ibm-c.pdx.osdl.net>
	 <20030515191921.GJ1429@dualathlon.random>
	 <1053036250.2696.33.camel@ibm-c.pdx.osdl.net>
	 <20030515231714.GL1429@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1053131245.2690.78.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 16 May 2003 17:27:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 16:17, Andrea Arcangeli wrote:

> no, the spin_lock only acts as a barrier in one way, not both ways, so
> an smp_something is still needed.
> 

Can you explain this more?  On a x86, isn't a spin_lock a lock; dec
instruction and the rmb() a lock; addl.  I thought x86 instructions
with lock prefix provided a memory barrier.

Just curious,

-- 
Daniel McNeil <daniel@osdl.org>

