Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWBRK5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWBRK5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 05:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBRK5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 05:57:25 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15395 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750988AbWBRK5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 05:57:25 -0500
Date: Sat, 18 Feb 2006 11:57:12 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: [patch] cpu hotplug documentation fix
Message-ID: <20060218105712.GC9216@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Looks like there was a merge conflict when patches
8f8b1138fc9f65e3591aac83a4ee394fef34ac1d and
255acee706b333b79f593dd366f16e1f107cccc3 were applied which wasn't properly
resolved. Fix this and add some additional description.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 Documentation/cpu-hotplug.txt |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
index e71bc6c..57a09f9 100644
--- a/Documentation/cpu-hotplug.txt
+++ b/Documentation/cpu-hotplug.txt
@@ -46,10 +46,12 @@ maxcpus=n    Restrict boot time cpus to 
              maxcpus=2 will only boot 2. You can choose to bring the
              other cpus later online, read FAQ's for more info.
 
-additional_cpus=n	[x86_64, s390 only] use this to limit hotpluggable cpus.
-                          This option sets
+additional_cpus*=n	Use this to limit hotpluggable cpus. This option sets
   			cpu_possible_map = cpu_present_map + additional_cpus
 
+(*) Option valid only for following architectures
+- x86_64, ia64, s390
+
 ia64 and x86_64 use the number of disabled local apics in ACPI tables MADT
 to determine the number of potentially hot-pluggable cpus. The implementation
 should only rely on this to count the #of cpus, but *MUST* not rely on the
@@ -57,6 +59,9 @@ apicid values in those tables for disabl
 mark such hot-pluggable cpus as disabled entries, one could use this
 parameter "additional_cpus=x" to represent those cpus in the cpu_possible_map.
 
+s390 uses the number of cpus it detects at IPL time to also the number of bits
+in cpu_possible_map. If it is desired to add additional cpus at a later time
+the number should be specified using this option or the possible_cpus option.
 
 possible_cpus=n		[s390 only] use this to set hotpluggable cpus.
 			This option sets possible_cpus bits in
