Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUC2Vg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUC2Vg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:36:27 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:31909
	"EHLO ground0.sonous.com") by vger.kernel.org with ESMTP
	id S263143AbUC2VgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:36:20 -0500
In-Reply-To: <Pine.LNX.4.53.0403291602340.2893@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 13:36:17 -0800
To: root@chaos.analogic.com
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2004, at 1:17 PM, Richard B. Johnson wrote:

> For glibc compatibility you need to get rid of the sym-link(s)
> /usr/include/asm and /usr/include/linux in older distributions.
> You need to replace those with headers copied from the kernel
> in use when the C runtime library was compiled. If you can't find
> those, you can either upgrade your C runtime library, or copy
> headers from some older kernel that was known to work.

I might be a bit confused here, but the problem with that, is that I'm 
effectively working backwards.  I've reverted the kernel version, but 
all other applications have been kept of course - this means that 
though I can keep those sym-links pointing to the correct kernel 
headers (those which were present when glibc was compiled), the current 
kernel (the reverted one) will obviously have different include files.

In order to compile the modules for the afformentioned hardware, those 
symlinks need to point to the 2.2.x kernel directories - will this 
break functionality of future compiled applications etc?

> Drivers are a different problem. There is no possibility
> of just compiling old drivers and having them work. Drivers
> need to be modified for each kernel version major version
> number and, sometimes, even minor version numbers.

right - luckily, at least so far, the modules and the applications that 
we have built for the hardware works on the newer (minor version update 
2.2.14 -> 2.2.26) kernel.

thanks,
-lev

