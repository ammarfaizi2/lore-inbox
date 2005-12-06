Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVLFIMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVLFIMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVLFIMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:12:53 -0500
Received: from fmr20.intel.com ([134.134.136.19]:36063 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750743AbVLFIMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:12:52 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [git pull 02/14] Add Wistron driver
Date: Tue, 6 Dec 2005 16:11:45 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A53FCC5@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [git pull 02/14] Add Wistron driver
thread-index: AcX3YAEsHiXYmxZDQfafrVT4fMthbgC2tw0A
From: "Yu, Luming" <luming.yu@intel.com>
To: <dtor_core@ameritech.net>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Vojtech Pavlik" <vojtech@suse.cz>,
       "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Dec 2005 08:11:46.0050 (UTC) FILETIME=[B325AE20:01C5FA3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 12/2/05, Yu, Luming <luming.yu@intel.com> wrote:
>> I just tested module wistron_btn on  one Acer Aspire laptop after
>> adding one dmi entry.  The wistron_btn found BIOS interfaces.
>> One visible error is the bluetooth light won't turn on upon
>> stroking bluetooth button.
>> Without wistron_btn module, the bluetooth light works.
>>  with acpi enabled, I didn't try acpi disabled)
>>
>
>Did you add the new keymap table with KE_BLUETOOTH to go with 
>that DMI entry?

Yes,  I added.
>
>> wistron_btn polls a cmos address to detect hotkey event.  It
>> is not necessary, because there do have ACPI interrupt triggered upon
>> hotkeys.
>>
>
>Unfortunately ACPI does not route these events through the input layer
>so aside from special buttons (like sleep) it is not very useful.

There are acpi daemon for any evetnts that needs user space attention.
I'm not sure if these events should be routed to input layer.
But, we can do that.

>
>> So, my suggestion is to disable this module when ACPI enabled.
>> We need to implement hotkey support from ACPI subsystem for my
>> Acer aspire laptop.
>
>I do not agree.

For my acer aspire laptop.
I added dmi entry, and keymap.

With acpi disabled, bluetooth light doesn't work
With acpi disabled + wistron module,  bluetooth light doesn't work.

With acpi enabled +  wistron module,  bluetooth light doesn't work

With acpi enabled - wistron module, bluetooth works.
>From these test cases, do you still think wistron driver can help my
laptop?

Thanks,
Luming
