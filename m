Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbUDGVfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbUDGVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:35:40 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:29869 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264150AbUDGVfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:35:39 -0400
Subject: Re: NUMA API for Linux
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1081373058.9061.16.camel@arrakis>
References: <1081373058.9061.16.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1081373709.9061.20.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 14:35:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself, but...

On Wed, 2004-04-07 at 14:24, Matthew Dobson wrote:
> Andi,
> 	I must be missing something here, but did you not include mempolicy.h
> and policy.c in these patches?  I can't seem to find them anywhere?!? 
> It's really hard to evaluate your patches if the core of them is
> missing!

Running make -j24 bzImage
In file included from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h:32: linux/mempolicy.h: No such file or directory
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [arch/i386/kernel/asm-offsets.s] Error 2

I'm guessing you just forgot the -N option to diff.  You might want to
add the -p option when you rediff and repost because it makes your
patches an order of magnitude easier to read when you can tell what
function the patch is modifying.

-Matt

