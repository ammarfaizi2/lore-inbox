Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268063AbUHSGHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268063AbUHSGHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUHSGHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:07:44 -0400
Received: from fmr10.intel.com ([192.55.52.30]:43680 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S268063AbUHSGHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:07:32 -0400
Subject: Re: kernel 2.6.8.1-mm1 ACPI bug ?
From: Len Brown <len.brown@intel.com>
To: Maximilian Decker <burbon04@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C36F4@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C36F4@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092895624.25902.199.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Aug 2004 02:07:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 03:50, Maximilian Decker wrote:
> Hi all,
> 
> it seems like there is a strange ACPI related bug in the current -mm 
> patch set... ?
> At least with my configuration the following happens:
> 
> 
> With vanilla kernel 2.6.7 oder 2.6.8 I get the following at bootup:
> 
> ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
> ACPI: Thermal Zone [TZ1] (30 C)
> ACPI: Thermal Zone [TZ2] (29 C)
> ACPI: Thermal Zone [TZ3] (26 C)
> cpufreq: CPU0 - ACPI performance management activated.
> ACPI: (supports S0 S3 S4 S4bios S5)
> 
> 
> With the current -mm patchset (at least with 2.6.8 rc to .1) I get the
> following:
> 
> ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
> ACPI: Thermal Zone [TZ1] (16 C)
>     ACPI-1133: *** Error: Method execution failed [\_TZ_.C204] (Node 
> dff45e00), AE_AML_PACKAGE_LIMIT
>     ACPI-1133: *** Error: Method execution failed [\_TZ_.C203] (Node 
> dff45c20), AE_AML_PACKAGE_LIMIT
>     ACPI-1133: *** Error: Method execution failed [\_TZ_.TZ2_._TMP] 
> (Node dff46580), AE_AML_PACKAGE_LIMIT
> ACPI: Thermal Zone [TZ3] (31 C)
> cpufreq: CPU0 - ACPI performance management activated.
> ACPI: (supports S0 S3 S4 S4bios S5)
> 
> 
> My hardware is a HP compaq nc8000, Pentium-M.
> The problem is that with the -mm kernels the CPU fan stops to work -
> causing temperature to raise very high ...... :-(
> 
> Are there any known problems ?

Please take stock 2.6.8.1 and apply the latest patch here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
and give it a go.

This will bring your kernel up to the same ACPI patch that is in the -mm
tree, but without all the other stuff in the mm tree.

If it fails, then ACPI broke.  If it works, then something in -mm broke
ACPI.

thanks,
-Len



