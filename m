Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTBLNoG>; Wed, 12 Feb 2003 08:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTBLNoG>; Wed, 12 Feb 2003 08:44:06 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34957 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267206AbTBLNoE>;
	Wed, 12 Feb 2003 08:44:04 -0500
Date: Wed, 12 Feb 2003 13:49:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: 2.5.60-dj2: lonkhaul.c doesn't compile
Message-ID: <20030212134941.GC3770@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@brodo.de>
References: <20030211182256.GA28903@codemonkey.org.uk> <20030212134706.GH17128@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212134706.GH17128@fs.tum.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 02:47:06PM +0100, Adrian Bunk wrote:
 > arch/i386/kernel/cpu/cpufreq/longhaul.c:644: `longhaul_driver' undeclared (first use in this function)
 > arch/i386/kernel/cpu/cpufreq/longhaul.c:644: (Each undeclared identifier is reported only once
 > arch/i386/kernel/cpu/cpufreq/longhaul.c:644: for each function it appears in.)
 > arch/i386/kernel/cpu/cpufreq/longhaul.c: At top level:
 > arch/i386/kernel/cpu/cpufreq/longhaul.c:650: `longhaul_driver' used prior to declaration
 > make[3]: *** [arch/i386/kernel/cpu/cpufreq/longhaul.o] Error 1

The longhaul_driver struct needs to be defined before longhaul_cpu_init()
You'll need to fix up forward declaration of longhaul_cpu_init() then
though too. Icky.
		
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
