Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUHSGtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUHSGtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 02:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUHSGtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 02:49:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:26508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268082AbUHSGs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 02:48:57 -0400
X-Authenticated: #849887
Message-ID: <41244D60.9000808@gmx.de>
Date: Thu, 19 Aug 2004 08:49:04 +0200
From: Maximilian Decker <burbon04@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040811
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8.1-mm1 ACPI bug ?
References: <566B962EB122634D86E6EE29E83DD808182C36F4@hdsmsx403.hd.intel.com> <1092895624.25902.199.camel@dhcppc4>
In-Reply-To: <1092895624.25902.199.camel@dhcppc4>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:

>On Wed, 2004-08-18 at 03:50, Maximilian Decker wrote:
>  
>
>>Hi all,
>>
>>it seems like there is a strange ACPI related bug in the current -mm 
>>patch set... ?
>>At least with my configuration the following happens:
>>
>>
>>With vanilla kernel 2.6.7 oder 2.6.8 I get the following at bootup:
>>
>>ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
>>ACPI: Thermal Zone [TZ1] (30 C)
>>ACPI: Thermal Zone [TZ2] (29 C)
>>ACPI: Thermal Zone [TZ3] (26 C)
>>cpufreq: CPU0 - ACPI performance management activated.
>>ACPI: (supports S0 S3 S4 S4bios S5)
>>
>>
>>With the current -mm patchset (at least with 2.6.8 rc to .1) I get the
>>following:
>>
>>ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
>>ACPI: Thermal Zone [TZ1] (16 C)
>>    ACPI-1133: *** Error: Method execution failed [\_TZ_.C204] (Node 
>>dff45e00), AE_AML_PACKAGE_LIMIT
>>    ACPI-1133: *** Error: Method execution failed [\_TZ_.C203] (Node 
>>dff45c20), AE_AML_PACKAGE_LIMIT
>>    ACPI-1133: *** Error: Method execution failed [\_TZ_.TZ2_._TMP] 
>>(Node dff46580), AE_AML_PACKAGE_LIMIT
>>ACPI: Thermal Zone [TZ3] (31 C)
>>cpufreq: CPU0 - ACPI performance management activated.
>>ACPI: (supports S0 S3 S4 S4bios S5)
>>
>>
>>My hardware is a HP compaq nc8000, Pentium-M.
>>The problem is that with the -mm kernels the CPU fan stops to work -
>>causing temperature to raise very high ...... :-(
>>
>>Are there any known problems ?
>>    
>>
>
>Please take stock 2.6.8.1 and apply the latest patch here:
>http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.8/
>and give it a go.
>
>This will bring your kernel up to the same ACPI patch that is in the -mm
>tree, but without all the other stuff in the mm tree.
>
>If it fails, then ACPI broke.  If it works, then something in -mm broke
>ACPI.
>
>thanks,
>-Len
>  
>

I just tried 2.6.8.1 with the given patch, same result.
As soon as ACPI starts up, TZ2 disappears and the cpu fan stops working.

If you need further information (lspci etc.) - please let me know, thanks !


-Maximilian



