Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbUDGWuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDGWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:50:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:22419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264197AbUDGWuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:50:17 -0400
Date: Wed, 7 Apr 2004 15:52:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mbligh@aracnet.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040407155225.14936e8a.akpm@osdl.org>
In-Reply-To: <20040408003809.01fc979e.ak@suse.de>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<5840000.1081377504@flay>
	<20040408003809.01fc979e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> We can discuss changes when someone shows numbers that additional 
> optimizations are needed. I haven't seen such numbers and I'm not convinced
> sharing is even a good idea from a design standpoint.  For the first version 
> I just aimed to get something working with straight forward code.
> 
> To put it all in perspective: a policy is 12 bytes on a 32bit machine
> (assuming MAX_NUMNODES <= 32) and 16 bytes on a 64bit machine
> (with MAX_NUMNODES <= 64)

sizeof(vm_area_struct) is a very sensitive thing on ia32.  If you expect
that anyone is likely to actually use the numa API on 32-bit, sharing
will be important.

It should be useful for SMT, yes?

