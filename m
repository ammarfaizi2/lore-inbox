Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbRHDUaT>; Sat, 4 Aug 2001 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269857AbRHDU37>; Sat, 4 Aug 2001 16:29:59 -0400
Received: from pine.novastar.com ([209.83.178.162]:38153 "HELO
	pine.novastar.com") by vger.kernel.org with SMTP id <S267670AbRHDU3u>;
	Sat, 4 Aug 2001 16:29:50 -0400
Date: Sat, 4 Aug 2001 11:48:13 -0500
From: David Blackman <david@whizziwig.com>
To: linux-kernel@vger.kernel.org, apmd-list@nit.ca
Subject: APM on Acer Travelmate 350te
Message-ID: <20010804114813.A21252@zaphod.whizziwig.com>
Reply-To: david@whizziwig.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey All-

	I have an acer travelmate 350te laptop, everything works
underlinux except the modem (duh) and power managment. With APM, apm
--suspend works, but the laptop never wakes up, and just shows the last
contents of the vga buffer, acpi in prior kernel versions (2.4.2 ->
2.4.5) would have a /proc/power, so I could get battery info by hand,
but no suspend, 2.4.7 has no /proc/power, or /proc/sys/acpi at all. 

	I don't know much about what I can do to fix the problem.
	
	The bios says version 'V3.3 R01-A0A'.

	Under 2.4.5 with acpi, I get this output:

ACPI: Core Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: plvl2lat=99 plvl3lat=999
ACPI: C2 enter=1417 C2 exit=354
ACPI: C3 enter=42905 C3 exit=3575
ACPI: Using ACPI idle
ACPI: If experiencing system slowness, try adding "acpi=no-idle" to cmdline
ACPI: System firmware supports: S0 S1 S4 S5
ACPI: found EC @ (0x62,0x66,GPE 34 GL 34)
AC Adapter: found
Cmbatt: Battery socket 0 occupied

	2.4.5 with apm

apm: BIOS version 1.2 Flags 0x0f (Driver version 1.14)

	I've tried every combination of driver opts to apm, as well as 
	changing	 apm_bios_entry.offset = apm_bios_info.offset;
	to 		 apm_bios_entry.offset = apm_bios_info.offset & 0xffff;
	which was a fix that worked for some older travelmates.

any help would be appreciated, if there's any more data I can extract
from my end, please let me know.

thanks,
--dave








