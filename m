Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286337AbRLTTht>; Thu, 20 Dec 2001 14:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286340AbRLTThn>; Thu, 20 Dec 2001 14:37:43 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:56972 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S286337AbRLTTh3>; Thu, 20 Dec 2001 14:37:29 -0500
Message-Id: <200112201851.LAA05800@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: esr@thyrsus.com
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Date: Thu, 20 Dec 2001 12:32:40 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov> <20011220135213.B18128@thyrsus.com>
In-Reply-To: <20011220135213.B18128@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 11:52 am, Eric S. Raymond wrote:
> Steven Cole <scole@lanl.gov>:
> > I see that in the very latest Configure.help version, 2.76,
> > available at http://www.tuxedo.org/~esr/cml2/ Eric has decided to
> > follow the following standard: IEC 60027-2, Second edition, 2000-11,
> > Letter symbols to be used in electrical technology - Part 2:
> > Telecommunications and electronics.  and has changed all the
> > abbreviations for Kilobyte (KB) to KiB, Megabyte (MB) to MiB, etc,
> > etc.
>
> This change came as a patch from David Woodhouse.  I think the new
> abbreviations are awful ugly, myself, but they do have the virtue of
> not being ambiguous.  So I swallowed hard and took the patch.

I personally agree with Matt Bernstein who wrote:
>I believe that the main purpose of documentation, help etc is to get the
>information across in a way that is most easily understood, ie that
>minimises the number of support questions.

I've obviously been wrong all along on this, but I had always assumed
(incorrectly) that mega when applied to binary things really meant 
2 to the 20th, and that the confusion came from disk manufacturers who
chose whatever definition made their products seem bigger.

So, if we really want to be pedantically correct, let's all swallow 
_really_ hard, and go all the way on this.  Or, are the UGLY changes
below actually technically wrong?

Cheers, and happy holidays,
Steven

--- Configure.help.2.76	Thu Dec 20 12:00:46 2001
+++ Configure.help	Thu Dec 20 12:08:13 2001
@@ -2,7 +2,8 @@
 #	Eric S. Raymond <mailto:esr@thyrsus.com>
 #	Steven Cole <mailto:elenstev@mesatop.com>
 #
-# Merged version 2.76: current with 2.4.17-rc2/2.5.1.
+# Merged version 2.77: current with 2.4.17-rc2/2.5.1.
+# Warning: A barf bag is a recommended accessory this version.
 #
 # This version of the Linux kernel configuration help texts
 # corresponds to kernel versions 2.4.x and 2.5.x.
@@ -334,25 +335,25 @@
 # Choice: himem
 High Memory support
 CONFIG_NOHIGHMEM
-  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
+  Linux can use up to 64 Gibibytes of physical memory on x86 systems.
   However, the address space of 32-bit x86 processors is only 4
-  Gigabytes large. That means that, if you have a large amount of
+  Gibibytes large. That means that, if you have a large amount of
   physical memory, not all of it can be "permanently mapped" by the
   kernel. The physical memory that's not permanently mapped is called
   "high memory".
 
   If you are compiling a kernel which will never run on a machine with
-  more than 960 megabytes of total physical RAM, answer "off" here
+  more than 960 mebibytes of total physical RAM, answer "off" here
   (default choice and suitable for most users). This will result in a
   "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
   virtual memory space and the remaining part of the 4GiB virtual memory
   space is used by the kernel to permanently map as much physical memory
   as possible.
 
-  If the machine has between 1 and 4 Gigabytes physical RAM, then
+  If the machine has between 1 and 4 Gibibytes physical RAM, then
   answer "4GB" here.
 
-  If more than 4 Gigabytes is used then answer "64GB" here. This
+  If more than 4 Gibibytes is used then answer "64GB" here. This
   selection turns Intel PAE (Physical Address Extension) mode on.
   PAE implements 3-level paging on IA32 processors. PAE is fully
   supported by Linux, PAE mode is implemented on all recent Intel
@@ -370,12 +371,12 @@
 4GB
 CONFIG_HIGHMEM4G
   Select this if you have a 32-bit processor and between 1 and 4
-  gigabytes of physical RAM.
+  gibibytes of physical RAM.
 
 64GB
 CONFIG_HIGHMEM64G
   Select this if you have a 32-bit processor and more than 4
-  gigabytes of physical RAM.
+  gibibytes of physical RAM.
 
 Normal floppy disk support
 CONFIG_BLK_DEV_FD
@@ -13509,7 +13510,7 @@
 Enable kernel debugging symbols
 CONFIG_DEBUGSYM
   When this is enabled, the User-Mode Linux binary will include
-  debugging symbols.  This enlarges the binary by a few megabytes,
+  debugging symbols.  This enlarges the binary by a few mebibytes,
   but aids in tracking down kernel problems in UML.  It is required
   if you intend to do any kernel development.
 
@@ -18296,7 +18297,7 @@
 
 MSND buffer size (KiB)
 CONFIG_MSND_FIFOSIZE
-  Configures the size of each audio buffer, in kilobytes, for
+  Configures the size of each audio buffer, in kibibytes, for
   recording and playing in the MultiSound drivers (both the Classic
   and Pinnacle). Larger values reduce the chance of data overruns at
   the expense of overall latency. If unsure, use the default.
@@ -18791,7 +18792,7 @@
 CONFIG_REMOTE_DEBUG
   If you say Y here, it will be possible to remotely debug the MIPS
   kernel using gdb. This enlarges your kernel image disk size by
-  several megabytes and requires a machine with more than 16 MiB,
+  several mebibytes and requires a machine with more than 16 MiB,
   better 32 MiB RAM to avoid excessive linking time. This is only
   useful for kernel hackers. If unsure, say N.
 
@@ -24244,7 +24245,7 @@
   kernel using gdb, if you have the gdb-sh-stub package from
   www.m17n.org (or any conforming standard LinuxSH BIOS) in FLASH or
   EPROM.  This enlarges your kernel image disk size by several
-  megabytes but allows you to load, run and debug the kernel image
+  mebibytes but allows you to load, run and debug the kernel image
   remotely using gdb.  This is only useful for kernel hackers.  If
   unsure, say N.
 
