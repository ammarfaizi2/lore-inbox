Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbTIAIPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTIAIPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 04:15:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34567 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261402AbTIAIPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 04:15:30 -0400
Date: Mon, 1 Sep 2003 09:15:24 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901091524.A15370@flint.arm.linux.org.uk>
Mail-Followup-To: "Paul J.Y. Lahaie" <pjlahaie@steamballoon.com>,
	Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <1062188787.4062.21.camel@elenuial.steamballoon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1062188787.4062.21.camel@elenuial.steamballoon.com>; from pjlahaie@steamballoon.com on Fri, Aug 29, 2003 at 04:26:28PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like an old kernel on your NetWinder.  Later 2.4 kernels
should get this right (by marking the pages uncacheable in user space.)

However, when I tried this program, it seemed to have some unexpected
results, sometimes claiming that its too slow, sometimes that the
store buffer isn't coherent, and sometimes saying that the cache
isn't coherent.

Oddly, davem's cache aliasing test program works every time.

It's something which I need to look into, but I don't know when I'm
going to find the time to delve into the memory management stuff.

On Fri, Aug 29, 2003 at 04:26:28PM -0400, Paul J.Y. Lahaie wrote:
> Corel NetWinder (275MHz StrongARM)
> Test separation: 4096 bytes: FAIL - cache not coherent
> Test separation: 8192 bytes: FAIL - cache not coherent
> Test separation: 16384 bytes: FAIL - cache not coherent
> Test separation: 32768 bytes: FAIL - cache not coherent
> Test separation: 65536 bytes: FAIL - cache not coherent
> Test separation: 131072 bytes: FAIL - cache not coherent
> Test separation: 262144 bytes: FAIL - cache not coherent
> Test separation: 524288 bytes: FAIL - cache not coherent
> Test separation: 1048576 bytes: FAIL - cache not coherent
> Test separation: 2097152 bytes: FAIL - cache not coherent
> Test separation: 4194304 bytes: FAIL - cache not coherent
> Test separation: 8388608 bytes: FAIL - cache not coherent
> Test separation: 16777216 bytes: FAIL - cache not coherent
> VM page alias coherency test: failed; will use copy buffers instead
> 
> cat /proc/cpuinfo
> Processor       : StrongARM-110 rev 3 (v4l)
> BogoMIPS        : 185.95
> Features        : swp half 26bit fastmult
>  
> Hardware        : Rebel-NetWinder
> Revision        : 52ff
> Serial          : 00000000000008bf

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

