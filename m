Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319351AbSH2ViL>; Thu, 29 Aug 2002 17:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSH2ViL>; Thu, 29 Aug 2002 17:38:11 -0400
Received: from holomorphy.com ([66.224.33.161]:32389 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319351AbSH2ViK>;
	Thu, 29 Aug 2002 17:38:10 -0400
Date: Thu, 29 Aug 2002 14:42:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile-time configurable NR_CPUS
Message-ID: <20020829214230.GH888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <1030635200.939.2561.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1030635200.939.2561.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 11:33:20AM -0400, Robert Love wrote:
> diff -urN linux-2.5.32/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.32/arch/i386/config.in	Tue Aug 27 15:26:39 2002
+++ linux/arch/i386/config.in	Wed Aug 28 19:15:32 2002
@@ -166,6 +166,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 

Could you make CONFIG_NR_CPUS only for non-NUMA-Q systems and hardwire
it to 32 for NUMA-Q, as the bugs in io_apic.c don't have fixes yet and
NUMA-Q's have enough IO-APIC's to trigger the bugs.


Thanks,
Bill
