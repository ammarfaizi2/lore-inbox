Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUADCBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUADCBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:01:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14279 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264444AbUADCBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:01:08 -0500
Date: Sun, 4 Jan 2004 02:00:53 +0000
From: Dave Jones <davej@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which .config processor for Centaur VIA Samual 2 stepping 03?
Message-ID: <20040104020053.GA10650@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <200312131430.40731.andrew@walrond.org> <20031213154201.GA13269@redhat.com> <bt72qv$chk$2@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bt72qv$chk$2@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 02:01:09PM -0500, Bill Davidsen wrote:
 > Dave Jones wrote:
 > 
 > >C3-2 is for Nehemiah. It signifies that we should use SSE instead of 3dnow.
 > 
 > Good thing to put in the help for the options?

arch/i386/Kconfig ...


config M386
	bool "386"
	---help---
	  This is the processor type of your CPU. This information is used for
	  optimizing purposes. In order to compile a kernel that can run on
	  all x86 CPU types (albeit not optimally fast), you can specify
	  "386" here.

	  The kernel will not necessarily run on earlier architectures than
	  the one you have chosen, e.g. a Pentium optimized kernel will run on
	  a PPro, but not necessarily on a i486.

	  Here are the settings recommended for greatest speed:
	  - "386" for the AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI
	  486DLC/DLC2, UMC 486SX-S and NexGen Nx586.  Only "386" kernels
	  will run on a 386 class machine.
	  - "486" for the AMD/Cyrix/IBM/Intel 486DX/DX2/DX4 or
	  SL/SLC/SLC2/SLC3/SX/SX2 and UMC U5D or U5S.
	  - "586" for generic Pentium CPUs lacking the TSC
	  (time stamp counter) register.
	  - "Pentium-Classic" for the Intel Pentium.
	  - "Pentium-MMX" for the Intel Pentium MMX.
	  - "Pentium-Pro" for the Intel Pentium Pro.
	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
	  - "Crusoe" for the Transmeta Crusoe series.
	  - "Winchip-C6" for original IDT Winchip.
	  - "Winchip-2" for IDT Winchip 2.
	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).
	  If you don't know what to do, choose "386".


config MVIAC3_2
	bool "VIA C3-2 (Nehemiah)"
	help
	  Select this for a VIA C3 "Nehemiah". Selecting this enables usage
	  of SSE and tells gcc to treat the CPU as a 686.
	  Note, this kernel will not boot on older (pre model 9) C3s.


-- 
 Dave Jones     http://www.codemonkey.org.uk
