Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263560AbREYGDs>; Fri, 25 May 2001 02:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263559AbREYGDj>; Fri, 25 May 2001 02:03:39 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:26129 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263558AbREYGDX>; Fri, 25 May 2001 02:03:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: esr@thyrsus.com
cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Configure.help entries wanted 
In-Reply-To: Your message of "Fri, 25 May 2001 01:22:00 -0400."
             <20010525012200.A5259@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 16:03:16 +1000
Message-ID: <23530.990770596@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001 01:22:00 -0400, 
"Eric S. Raymond" <esr@thyrsus.com> wrote:
>Amaze your friends and confound your enemies with your hackerly erudition --
>contribute a Configure.help entry today!
>
>IA64 port:
>
>CONFIG_DISABLE_VHPT
>CONFIG_MCKINLEY_A0_SPECIFIC
>CONFIG_MCKINLEY_ASTEP_SPECIFIC
>CONFIG_IA64_DEBUG_CMPXCHG
>CONFIG_IA64_DEBUG_IRQ
>CONFIG_IA64_EARLY_PRINTK
>CONFIG_IA64_PRINT_HAZARDS

I claim my erudition prize (do I get steak knives with that?).
Against 2.4.4-ia64-010508.

Index: 4.20/Documentation/Configure.help
--- 4.20/Documentation/Configure.help Wed, 09 May 2001 14:46:25 +1000 kaos (linux-2.4/Z/c/10_Configure. 1.1.2.8.2.12 644)
+++ 4.20(w)/Documentation/Configure.help Fri, 25 May 2001 15:56:18 +1000 kaos (linux-2.4/Z/c/10_Configure. 1.1.2.8.2.12 644)
@@ -17678,6 +17678,49 @@ CONFIG_IA64_MCA
   Say Y here to enable machine check support for IA-64.  If you're
   unsure, answer Y.
 
+Disable IA-64 Virtual Hash Page Table
+CONFIG_DISABLE_VHPT
+  The Virtual Hash Page Table (VHPT) enhances virtual address
+  translation performance.  Normally you want the VHPT active but you
+  can select this option to disable the VHPT for debugging.  If you're
+  unsure, answer N.
+
+McKinley A-step specific code
+CONFIG_MCKINLEY_ASTEP_SPECIFIC
+  Select this option to build a kernel for an IA64 McKinley system
+  with any A-stepping CPU.
+
+McKinley A0/A1-step specific code
+CONFIG_MCKINLEY_A0_SPECIFIC
+  Select this option to build a kernel for an IA64 McKinley system
+  with an A0 or A1 stepping CPU.
+
+IA64 compare-and-exchange bug checking
+CONFIG_IA64_DEBUG_CMPXCHG
+  Selecting this option turns on bug checking for the IA64
+  compare-and-exchange instructions.  This is slow!  If you're unsure,
+  select N.
+
+IA64 IRQ bug checking
+CONFIG_IA64_DEBUG_IRQ
+  Selecting this option turns on bug checking for the IA64 irq_save and
+  restore instructions.  This is slow!  If you're unsure, select N.
+
+IA64 Early printk support
+CONFIG_IA64_EARLY_PRINTK
+  Selecting this option uses the VGA screen for printk() output before
+  the consoles are initialised.  It is useful for debugging problems
+  early in the boot process, but only if you have a VGA screen
+  attached.  If you're unsure, select N.
+
+IA64 Print Hazards
+CONFIG_IA64_PRINT_HAZARDS
+  Selecting this option prints more information for Illegal Dependency
+  Faults, that is, for Read after Write, Write after Write or Write
+  after Read violations.  This option is ignored if you are compiling
+  for an Itanium A step processor (CONFIG_ITANIUM_ASTEP_SPECIFIC).  If
+  you're unsure, select Y.
+
 Performance monitor support
 CONFIG_PERFMON
   Selects whether support for the IA-64 performance monitor hardware

