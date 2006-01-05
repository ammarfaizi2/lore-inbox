Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWAEF2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWAEF2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 00:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWAEF2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 00:28:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750963AbWAEF2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 00:28:25 -0500
Date: Wed, 4 Jan 2006 21:27:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: bcollins@ubuntu.com, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH 07/15] acpi: Add list of IBM R40 laptops to
 processor_power dmi table.
Message-Id: <20060104212751.1670e058.akpm@osdl.org>
In-Reply-To: <20060105034738.GF2658@redhat.com>
References: <0ISL00NX49551L@a34-mta01.direcway.com>
	<20060105034738.GF2658@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Jan 04, 2006 at 05:00:25PM -0500, Ben Collins wrote:
>  > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> There's a variant of this in -mm already, (albeit with horked indentation)
> Does your diff have all the same entries that one does ?
> (If so, I prefer yours :)

Below.

> This is also being tracked at http://bugme.osdl.org/show_bug.cgi?id=3549
> Len seemed to have an objection against merging this, but if every distro
> is carrying it anyway, it seems kinda pointless not to imo.
> 

I don't know what the problem is.  I've been sitting on it since September
and have sent it five times, to no effect.


From: Thomas Rosner <kernel-bugs@digital-trauma.de>

This adds all known BIOS versions of IBM R40e Laptops to the C2/C3
processor state blacklist and thus prevents them from crashing.  Fixes Bug
#3549.

Implementation is probably overly verbose, but DMI_MATCH seems to give us
no choice.

Signed-off-by: Thomas Rosner <kernel-bugs@digital-trauma.de>
Cc: <linux-acpi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |  115 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 101 insertions(+), 14 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549 drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-disable-c2-c3-for-_all_-ibm-r40e-laptops-for-2613-bug-3549	2005-11-05 02:22:48.000000000 -0800
+++ devel-akpm/drivers/acpi/processor_idle.c	2005-11-05 02:22:48.000000000 -0800
@@ -95,23 +95,110 @@ static int set_max_cstate(struct dmi_sys
 }
 
 static struct dmi_system_id __initdata processor_power_dmi_table[] = {
+	/* The known versions of IBM R40e BIOS */
 	{set_max_cstate, "IBM ThinkPad R40e", {
-					       DMI_MATCH(DMI_BIOS_VENDOR,
-							 "IBM"),
-					       DMI_MATCH(DMI_BIOS_VERSION,
-							 "1SET60WW")},
-	 (void *)1},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET32WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET43WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET45WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET47WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET50WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET52WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET55WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET56WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET59WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET60WW")},
+			(void *)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET61WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET62WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET64WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET65WW") },
+			(void*)1},
+	{set_max_cstate, "IBM ThinkPad R40e", {
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"IBM"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"1SET68WW") },
+			(void*)1},
+	/* Other laptops, same problem */
 	{set_max_cstate, "Medion 41700", {
-					  DMI_MATCH(DMI_BIOS_VENDOR,
-						    "Phoenix Technologies LTD"),
-					  DMI_MATCH(DMI_BIOS_VERSION,
-						    "R01-A1J")}, (void *)1},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"R01-A1J")},
+			(void *)1},
 	{set_max_cstate, "Clevo 5600D", {
-					 DMI_MATCH(DMI_BIOS_VENDOR,
-						   "Phoenix Technologies LTD"),
-					 DMI_MATCH(DMI_BIOS_VERSION,
-						   "SHE845M0.86C.0013.D.0302131307")},
-	 (void *)2},
+			DMI_MATCH(DMI_BIOS_VENDOR,
+				"Phoenix Technologies LTD"),
+			DMI_MATCH(DMI_BIOS_VERSION,
+				"SHE845M0.86C.0013.D.0302131307")},
+			(void *)2},
 	{},
 };
 
_

