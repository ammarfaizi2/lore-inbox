Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWDSLBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWDSLBe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDSLBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:01:33 -0400
Received: from tensor.andric.com ([213.154.244.69]:17384 "EHLO
	tensor.andric.com") by vger.kernel.org with ESMTP id S1750885AbWDSLBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:01:32 -0400
Message-ID: <4446187C.2090603@andric.com>
Date: Wed, 19 Apr 2006 13:01:16 +0200
From: Dimitry Andric <dimitry@andric.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060418)
MIME-Version: 1.0
To: Ben Dooks <ben-linux-arm@fluff.org>
CC: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: rename arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx
References: <20060418165204.GG2516@trinity.fluff.org>
In-Reply-To: <20060418165204.GG2516@trinity.fluff.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> With the advent of the s3c2410 port adding support for
> more of the samsung SoC product line (s3c2440, s3c2442,
> s3c2400) there have been several requests by other people
> to rename the (in their opinion) increasingly inaccurate
> arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx.

Well, if you start this way, you might also consider renaming it to
mach-s3cxxxx, since Samsung also seems to have S3C3410, S3C44B0 and who
knows what else.  Otherwise you'd maybe have to do such an operation
again in the future...

Also, I've always found the dichotomy of having
"include/asm-arm/arch-s3c2410" and "arch/arm/mach-s3c2410" rather weird.
Isn't s3cxxxx an "architecture", instead of a specific machine?  If so,
arch/arm/arch-s3cxxxx would be more logical.

Anyway, by starting to rename directories, you start a never-ending
quest, and you'll stress the abilities of most version control systems
too.  Your huge diff for just one rename operation already shows this.

There are certainly a lot more directories (also not specifically
arm-related ones) in the Linux kernel source that could be renamed to be
more logical, but I'd say the cost is rather large.  E.g. difficulty
merging patches on older kernels and other version control difficulties.

Cheers,
Dimitry
