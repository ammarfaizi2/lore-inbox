Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUIJR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUIJR4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUIJR4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:56:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27359 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267696AbUIJRzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:55:23 -0400
Date: Fri, 10 Sep 2004 10:54:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nathan Bryant <nbryant@optonline.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <6330000.1094838877@flay>
In-Reply-To: <4141D415.6050705@optonline.net>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain> <593560000.1094826651@[10.10.2.4]> <chsivd$827$1@sea.gmane.org> <4141D415.6050705@optonline.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Its probably appropriate to drop gcc 2.x support at that point too since
>>>> it's the major cause of remaining problems
>>> 
>>> 
>>> What problems does it cause? 2.95.4 still seems to work fine for me.
>> 
>> 
>> The latest gcc2 on the ftp.gnu.org site is gcc 2.95.3. There is 
>> officially no such thing as "gcc 2.95.4". Probably you are talking about 
>> a patched version of some gcc2 cvs snapshot - that's what distros 
>> provide. Please specify exactly what gcc version you are talking about.
> 
> 2.95.4, if I remember correctly, contained fixes that went onto the gcc 2.95 branch after 2.95.3 was released. Some of the fixes were for Linux-2.2/2.4 and glibc2.2 compatibility. This compiler was distributed by Debian, I think.
> 
>> 
>> And there _is_ problem with gcc-2.95.3-compiled kernel: latest cvs glibc 
>> testsuite segfaults in nptl tests. There are no failures with the kernel 
>> identically configured, but compiled with gcc 3.3.4 or 3.4.1. So gcc 
>> 2.95.3 as supplied by gnu.org miscompiles the kernel (futexes?). Either 
>> fix the kernel or drop gcc2 support.

If 2.95.3 is broken, then drop that. Before dropping gcc2 support entirely,
you should prove all versions are broken.

And yes, the 2.95.4 I've been using happily for about 4 years is Debian.
Not only does it compile about twice as quickly, it produces better code
than anything else I've tested (though 3.x is finally getting close).

M.

