Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUHRHuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUHRHuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 03:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUHRHuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 03:50:00 -0400
Received: from pop.gmx.net ([213.165.64.20]:54451 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264299AbUHRHt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 03:49:57 -0400
X-Authenticated: #849887
Message-ID: <41230A29.4060002@gmx.de>
Date: Wed, 18 Aug 2004 09:50:01 +0200
From: Maximilian Decker <burbon04@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040811
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.8.1-mm1 ACPI bug ?
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

it seems like there is a strange ACPI related bug in the current -mm 
patch set... ?
At least with my configuration the following happens:


With vanilla kernel 2.6.7 oder 2.6.8 I get the following at bootup:

ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (30 C)
ACPI: Thermal Zone [TZ2] (29 C)
ACPI: Thermal Zone [TZ3] (26 C)
cpufreq: CPU0 - ACPI performance management activated.
ACPI: (supports S0 S3 S4 S4bios S5)


With the current -mm patchset (at least with 2.6.8 rc to .1) I get the 
following:

ACPI: Processor [CPU0] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [TZ1] (16 C)
    ACPI-1133: *** Error: Method execution failed [\_TZ_.C204] (Node 
dff45e00), AE_AML_PACKAGE_LIMIT
    ACPI-1133: *** Error: Method execution failed [\_TZ_.C203] (Node 
dff45c20), AE_AML_PACKAGE_LIMIT
    ACPI-1133: *** Error: Method execution failed [\_TZ_.TZ2_._TMP] 
(Node dff46580), AE_AML_PACKAGE_LIMIT
ACPI: Thermal Zone [TZ3] (31 C)
cpufreq: CPU0 - ACPI performance management activated.
ACPI: (supports S0 S3 S4 S4bios S5)


My hardware is a HP compaq nc8000, Pentium-M.
The problem is that with the -mm kernels the CPU fan stops to work -
causing temperature to raise very high ...... :-(

Are there any known problems ?


thanks,

Maximilian


(please CC me as I am not subscribed to the list ...)





