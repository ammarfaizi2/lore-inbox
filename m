Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTEJOoL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTEJOoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:44:11 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:49891 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264279AbTEJOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:44:06 -0400
Date: Sat, 10 May 2003 15:56:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.69-dj1
Message-ID: <20030510145653.GA26216@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly a real big set (~200KB) of AGP changes that I'd like people
to give a testing, but a bunch of other bits and pieces too.

ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.69/

		Dave

Changes since 2.5.60-dj2:
- -dj leftovers
  Drop lots of unneeded/broken bits.
- Lots of other leftovers from older -dj patches
  This stuff needs sorting, and some more bits throwing out.
  There's lots of 2.4 forward port stuff here, and still lots
  more to come.
- Latest from Linus' bk tree.
  (Just there to help me stay in sync)
- Latest bits from the cpufreq tree.
ChangeSet@1.1136, 2003-05-01 00:09:19+01:00, davej@codemonkey.org.uk
  [CPUFREQ] Remove not needed ;'s from macro definitions.

ChangeSet@1.1181, 2003-04-28 18:13:40+01:00, davej@codemonkey.org.uk
  [CPUFREQ] Acer Aspire's have broken PST tables in one BIOS rev. DMI blacklist it.

ChangeSet@1.1180, 2003-04-24 13:14:23+01:00, davej@codemonkey.org.uk
 [CPUFREQ] Fix powernow-k7 hang.
  Some laptops don't like jumping from (for eg) 800MHz->1200MHz, but
  will happily go from 800->1000->1200. The problem is caused by us
  changing the FID and the VID at the same time. The spec says we have
  to change them seperately. This actually buys us something extra anyway,
  as we can now set the FID lazily as well as the VID.

- Latest pull of agpgart tree, with following csets..

ChangeSet@1.1244, 2003-05-10 14:35:12+01:00, davej@codemonkey.org.uk
  [AGPGART] Make the agp 3.5 use the agp3 code for enabling, leaving just the isoch stuff in isoch.c
ChangeSet@1.1243, 2003-05-10 10:03:51+01:00, davej@codemonkey.org.uk
  [AGPGART] CodingStyle nitpicks for isoch.c

ChangeSet@1.1242, 2003-05-10 09:41:28+01:00, davej@codemonkey.org.uk
  [AGPGART] Use symbolic defines for isoch registers in isoch code.

ChangeSet@1.1241, 2003-05-10 09:25:16+01:00, davej@codemonkey.org.uk
  [AGPGART] Add missing #defines from last checkin.

ChangeSet@1.1240, 2003-05-10 09:22:49+01:00, davej@codemonkey.org.uk
  [AGPGART] Make sure we don't poke reserved bits when enabling agp v3

ChangeSet@1.1239, 2003-05-10 09:13:50+01:00, davej@codemonkey.org.uk
  [AGPGART] Add proper AGP3 initialisation routine.

ChangeSet@1.1238, 2003-05-10 08:15:16+01:00, davej@codemonkey.org.uk
  [AGPGART] death of generic-3.0.c  = folded into generic.c

ChangeSet@1.1237, 2003-05-09 12:31:04+01:00, davej@codemonkey.org.uk
  [AGPGART] Remove duplicate copying of ->chipset in agp_copy_info()

ChangeSet@1.1236, 2003-05-06 19:24:37+01:00, davej@codemonkey.org.uk
  [AGPGART] Remove unneeded exports.
  These functions should only be called indirectly from agp_generic_enable()

ChangeSet@1.1235, 2003-05-06 19:20:21+01:00, davej@codemonkey.org.uk
  [AGPGART] Only enable isochronous transfers on AGP3.5 chipsets.
  The standard says that 3.0 chipsets don't support these extensions.
  Move the isoch stuff out into isoch.c leaving behind a shell for basic
  AGP3.0 enabling (to be written).

ChangeSet@1.1234, 2003-05-05 21:39:31+01:00, davej@codemonkey.org.uk
  [AGPGART] Work around AMD 8151 errata.
  Some revisions incorrectly report they support v3.5 of the AGP spec, when
  they are actually only 3.0 compliant.

ChangeSet@1.1233, 2003-05-05 21:37:30+01:00, davej@codemonkey.org.uk
  [AGPGART] Store agp revision in agp_bridge struct.
  There are a few places we do spec revision compliance checks, this cset
  generalises that function, and removes some duplicated functionality.

ChangeSet@1.1232, 2003-05-05 15:16:17+01:00, davej@codemonkey.org.uk
  [AGPGART] Skip devices with no AGP headers sooner.

ChangeSet@1.1231, 2003-05-05 02:37:40+01:00, davej@codemonkey.org.uk
  [AGPGART] Disable debugging printk's again.
  With the 'AGP bug' solved, we don't need this noise for a while...

ChangeSet@1.1191, 2003-05-03 02:21:32+01:00, davej@codemonkey.org.uk
  [AGPGART] Intel I875P support.
  From Matt Tolentino.

ChangeSet@1.1188, 2003-05-01 19:35:27+01:00, davej@codemonkey.org.uk
  [AGPGART] Turn on debugging printks for a while.
  Lets see if we can't track down some of the stranger reports.
  Also fix up the macro not to printk some ': ' it doesnt need to.

ChangeSet@1.1187, 2003-05-01 19:33:26+01:00, davej@codemonkey.org.uk
  [AGPGART] missing %p in debug printk

ChangeSet@1.1186, 2003-05-01 19:32:22+01:00, davej@codemonkey.org.uk
  [AGPGART] Kill off some typedefs.
  Note, I'm leaving behind the ones not in #ifdef __KERNEL__ for now, as I'm
  not sure just what userspace stuff that might break.

ChangeSet@1.1185, 2003-05-01 02:59:26+01:00, davej@codemonkey.org.uk
  [AGPGART] more kconfig cleanups
  - Alphabetical order of items.
  - Fixup the IOMMU dependancy problem (Roman Zippel)
  - Word all options similarly (Add 'chipset' to some descriptions)
  - Remove unused CONFIG_AGP_GART
  - Fix up incomplete alpha tristate

ChangeSet@1.1184, 2003-05-01 02:43:08+01:00, davej@codemonkey.org.uk
  [AGPGART] Move debugging macros to header so they can be used in other parts of agpgart.

ChangeSet@1.1183, 2003-05-01 02:41:16+01:00, davej@codemonkey.org.uk
  [AGPGART] Fix incorrect type warning.

ChangeSet@1.1137, 2003-05-01 01:30:58+01:00, davej@codemonkey.org.uk
  [AGPGART] Remove duplicate code in i810/i830 alloc_by_type functions.

ChangeSet@1.1136, 2003-05-01 01:29:49+01:00, davej@codemonkey.org.uk
  [AGPGART] Bulletproofing. NULL ptrs after freeing them.

ChangeSet@1.1135, 2003-04-30 23:56:19+01:00, davej@codemonkey.org.uk
  [AGPGART] Add some debugging printk's. Based on Linus' earlier patch.

ChangeSet@1.1133, 2003-04-28 02:32:41+01:00, davej@codemonkey.org.uk
  [AGPGART] Fix linking error.

ChangeSet@1.1132, 2003-04-27 21:44:07+01:00, davej@codemonkey.org.uk
  [AGPGART] Shrink chipset_type enum (compile fix)
  Missing part of hch's last cset.

ChangeSet@1.1131, 2003-04-27 21:15:40+01:00, davej@codemonkey.org.uk
  [AGPGART] Fix Kconfig typo

ChangeSet@1.1130, 2003-04-27 21:14:58+01:00, davej@codemonkey.org.uk
  [AGPGART] proper agp_bridge_driver.
  Christoph with the goods once more...
  >Okay, this does the converion for all drivers, it's ontop of my
  >previous patches.  enum chipset_type has shrunk to NOT_SUPPORTED
  >and SUPPORTED, but I'd like to postpone killing it entirely
  >or replacing it by a bool - drm pokes into this and we need to  
  >redo the agpgart <-> drm interface for support of multiple garts
  >anyway.

ChangeSet@1.1129, 2003-04-27 19:52:51+01:00, davej@codemonkey.org.uk
  [AGPGART] give all agpgart drivers a ->remove pci method.
  You guessed it, yup. from Christoph again.

ChangeSet@1.1128, 2003-04-27 19:40:23+01:00, davej@codemonkey.org.uk
  [AGPGART] don't dereference agp_bridge in generic-3.0.c
  Yet more from Christoph..
  >If agp_3_0_node_enable gets a struct agp_bridge_data * all of the
  >generic-3.0.c can be cleaned up easily to never look at agp_bridge
  >directly.  Now only backend.c, generic.c and the actual drivers
  >are left looking at it:)

ChangeSet@1.1127, 2003-04-27 19:27:24+01:00, davej@codemonkey.org.uk
  [AGPGART] Add back dummy module exit to keep things happy.

ChangeSet@1.1126, 2003-04-27 19:20:41+01:00, davej@codemonkey.org.uk
  [AGPGART] Nvidia GART cleanups.
  Christoph cleaned up a lot of the mess here. We're back to nearly killing
  off the chipset_type enum, moved the register definitions to the code that
  uses it, and given it a proper pci .remove function.

ChangeSet@1.1125, 2003-04-27 19:17:31+01:00, davej@codemonkey.org.uk
  [AGPGART] cleanup agp backend.c a bit
  More from Christoph.
  
  Most style nitpicks and a bit more explicitly passing struct
  agp_bridge_data around.

ChangeSet@1.1118.28.61, 2003-04-27 19:03:06+01:00, davej@codemonkey.org.uk
  [AGPGART] fix macros that expect agp_bridge in global scope
  From Christoph Hellwig

ChangeSet@1.1118.28.60, 2003-04-25 17:43:47+01:00, davej@tetrachloride.(none)
  [AGPGART] Fix kconfig dependancies.
  - Don't show x86 GARTs on alpha

ChangeSet@1.1118.28.59, 2003-04-25 17:43:41+01:00, davej@tetrachloride.(none)
  [AGPGART] i855PM support from Bill Nottingham.
  Mainly adding a PCI id, unfortunately, requires
  renaming the i855GM PCI ids to avoid name conflict. Also renames some
  of the i855GM constants from i855PM to i855GM.

ChangeSet@1.1118.28.58, 2003-04-25 17:43:35+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove semaphore abstraction.

ChangeSet@1.1118.28.57, 2003-04-25 17:43:25+01:00, davej@tetrachloride.(none)
  [AGPGART] Misc backend source tidy up.

ChangeSet@1.1118.28.56, 2003-04-25 17:43:18+01:00, davej@tetrachloride.(none)
  [AGPGART] Move function prototypes to headers.

ChangeSet@1.1118.28.55, 2003-04-25 17:43:13+01:00, davej@tetrachloride.(none)
  [AGPGART] kdoc'ify some of the function header comments.

ChangeSet@1.1118.28.54, 2003-04-25 17:43:07+01:00, davej@tetrachloride.(none)
  [AGPGART] Move function description comments from headers to the code they document.

ChangeSet@1.1118.28.53, 2003-04-25 17:43:01+01:00, davej@tetrachloride.(none)
  [AGPGART] EXPORT_SYMBOL cleanups. Also move the global_cache_flush routine to generic.c

ChangeSet@1.1118.28.52, 2003-04-25 17:42:55+01:00, davej@tetrachloride.(none)
  [AGPGART] Fix typo that stopped nvidia GART driver being built

ChangeSet@1.1118.28.51, 2003-04-25 17:42:48+01:00, davej@tetrachloride.(none)
  [AGPGART] Fall back to non-isochronous xfers if setting up isochronous xfers fails.

ChangeSet@1.1118.28.50, 2003-04-25 17:42:42+01:00, davej@tetrachloride.(none)
  [AGPGART] Convert several functions to return void.
  They only ever returned a single value.

ChangeSet@1.1118.28.49, 2003-04-25 17:42:35+01:00, davej@tetrachloride.(none)
  [AGPGART] use symbols instead of hardcoded values in generic-3.0
  Lots more work to do here.

ChangeSet@1.1118.28.48, 2003-04-25 17:42:29+01:00, davej@tetrachloride.(none)
  [AGPGART] Don't configure agp bridges more than once if there is >1 of them.

ChangeSet@1.1118.28.47, 2003-04-25 17:42:22+01:00, davej@tetrachloride.(none)
  [AGPGART] Add more defines to kill off hardcoded values

ChangeSet@1.1118.28.46, 2003-04-25 17:42:16+01:00, davej@tetrachloride.(none)
  [AGPGART] Add symbolic constants for AGP mode setting.
  bye bye icky hardcoded values.

ChangeSet@1.1118.28.45, 2003-04-25 17:42:10+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove unneeded settings of bridge->type.
  It's now done in the static structs.

ChangeSet@1.1118.28.44, 2003-04-25 17:42:03+01:00, davej@tetrachloride.(none)
  [AGPGART] Makefile cleanups.
  - the makefile is not the right place to describe the driver
  - remove some junk

ChangeSet@1.1118.28.43, 2003-04-25 17:41:58+01:00, davej@tetrachloride.(none)
  [AGPGART] Merge NVIDIA nForce / nForce2 AGP driver.
  Based upon code written by NVIDIA for agpgart 2.4, forward ported and
  cleaned up slightly by me. This still needs work, and is untested.

ChangeSet@1.1118.28.42, 2003-04-25 17:41:51+01:00, davej@tetrachloride.(none)
  [AGPGART] Replace enum users with own methods.
  By introducing a few extra functions, we can kill off a few extra members
  of the enum. More work from Christoph Hellwig.

ChangeSet@1.1118.28.41, 2003-04-25 17:41:45+01:00, davej@tetrachloride.(none)
  [AGPGART] More setup routine -> static struct conversions.
  Again from Christoph Hellwig.

ChangeSet@1.1118.28.40, 2003-04-25 17:41:38+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove unneeded enums from AMD k7 gart driver

ChangeSet@1.1118.28.39, 2003-04-25 17:41:32+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove useless enums from serverworks gart driver

ChangeSet@1.1118.28.38, 2003-04-25 17:41:26+01:00, davej@tetrachloride.(none)
  [AGPGART] Fix typo in via-agp. s/PM400/P4M400/

ChangeSet@1.1118.28.37, 2003-04-25 17:41:19+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove stale comment

ChangeSet@1.1118.28.36, 2003-04-25 17:41:13+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove unused ALi enums.

ChangeSet@1.1118.28.35, 2003-04-25 17:41:06+01:00, davej@tetrachloride.(none)
  [AGPGART] Remove unneeded enums from intel gart driver.

ChangeSet@1.1118.28.34, 2003-04-25 17:40:59+01:00, davej@tetrachloride.(none)
  [AGPGART] intel agp init cleanups.
  From Christoph Hellwig.
  (1) Kill the _setup functions - most of it can be nice, static
      structs - the few remainders are handled better elsewhere
  (2) _one_ big switch in ->probe assigning these tables.
  
  Almost 200 lOC gone and it's even readable :)

ChangeSet@1.1118.28.33, 2003-04-25 17:40:50+01:00, davej@tetrachloride.(none)
  [AGPGART] Hammer GART can use generic enable routines now.


