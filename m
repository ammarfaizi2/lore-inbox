Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUAFCPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUAFCPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:15:36 -0500
Received: from [66.62.77.7] ([66.62.77.7]:46047 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265255AbUAFCPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:15:15 -0500
Subject: RE: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
From: Dax Kelson <dax@gurulabs.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>
References: <3ACA40606221794F80A5670F0AF15F8401720C78@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1073356057.2687.2.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 19:27:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 18:03, Yu, Luming wrote:
> >Subject: [ACPI] ACPI battery issue - Dell Inspiron 4150 - 2.6.1-rc1-mm2
> >
> >Found at boot: 
> >ACPI: Battery Slot [BAT0] (battery present)
> >ACPI: Battery Slot [BAT1] (battery present)
> >But no run-time information:
> 
> Some DELL battery issues in recent kernel are solved by
> patch filed at http://bugzilla.kernel.org/show_bug.cgi?id=1766 .
> 
> Is it worthy to have it a try?

Seems to work ... is it normal to have the "unknown" values below when
plugged in?

$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      66000 mWh
present voltage:         16501 mV

$ cat /proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         65120 mWh
last full capacity:      54980 mWh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 3000 mWh
design capacity low:     1000 mWh
capacity granularity 1:  200 mWh
capacity granularity 2:  200 mWh
model number:            LIP8120DL
serial number:           5122
battery type:            LION
OEM info:                Sony C

When unplugged:

$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            2743 mW
remaining capacity:      52340 mWh
present voltage:         16526 mV


