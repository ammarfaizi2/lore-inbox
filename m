Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270863AbTHQUqD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270988AbTHQUqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:46:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:11212 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270863AbTHQUqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:46:00 -0400
Date: Sun, 17 Aug 2003 21:45:15 +0100
From: Dave Jones <davej@redhat.com>
To: "David B. Stevens" <dsteven3@maine.rr.com>
Cc: Jamie Lokier <jamie@shareable.org>, michaelc <michaelc@turbolinux.com.cn>,
       linux-kernel@vger.kernel.org
Subject: Re: about PENTIUM4 cache line
Message-ID: <20030817204514.GB2225@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David B. Stevens" <dsteven3@maine.rr.com>,
	Jamie Lokier <jamie@shareable.org>,
	michaelc <michaelc@turbolinux.com.cn>, linux-kernel@vger.kernel.org
References: <865464921.20010309170338@turbolinux.com.cn> <20030817202534.GC3543@mail.jlokier.co.uk> <3F3FE763.20503@maine.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3FE763.20503@maine.rr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 04:36:51PM -0400, David B. Stevens wrote:
 > What's even more interesting is the following:

why ?

 > tux:/usr/src/linux-2.6.0-test3 # grep -r "CONFIG_X86_L1_CACHE_SHIFT" *
 > arch/i386/defconfig:CONFIG_X86_L1_CACHE_SHIFT=7
 > arch/x86_64/defconfig:CONFIG_X86_L1_CACHE_SHIFT=6

correct default values for P4 and Hammer respectively.

 > include/asm-x86_64/cache.h:#define L1_CACHE_SHIFT 
 > (CONFIG_X86_L1_CACHE_SHIFT)

Looks sane.

 > include/linux/autoconf.h:#define CONFIG_X86_L1_CACHE_SHIFT 5

compile-time generated from .config

 > include/asm-i386/cache.h:#define L1_CACHE_SHIFT (CONFIG_X86_L1_CACHE_SHIFT)
 > include/asm/cache.h:#define L1_CACHE_SHIFT      (CONFIG_X86_L1_CACHE_SHIFT)

looks sane

 > include/config/x86/l1/cache/shift.h:#define CONFIG_X86_L1_CACHE_SHIFT 5

compile time generated from .config.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
