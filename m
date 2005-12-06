Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLFI6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLFI6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVLFI6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:58:36 -0500
Received: from fmr19.intel.com ([134.134.136.18]:13214 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932090AbVLFI6f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:58:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [git pull 02/14] Add Wistron driver
Date: Tue, 6 Dec 2005 16:57:17 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A53FD73@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [git pull 02/14] Add Wistron driver
thread-index: AcX6P0DnYk2ZDn5FStGa5YKZAuCjBwAA6oIQ
From: "Yu, Luming" <luming.yu@intel.com>
To: "Miloslav Trmac" <mitr@volny.cz>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Dec 2005 08:57:18.0584 (UTC) FILETIME=[0FDD4780:01C5FA43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Miloslav Trmac wrote:
>> Yu, Luming wrote:
>>>>> I just tested module wistron_btn on  one Acer Aspire laptop after 
>>>>> adding one dmi entry.  The wistron_btn found BIOS interfaces.
>
>>>>If your laptop provides the hotkey events via ACPI, simply don't use
>>>>wistron_btns.
>>>
>>>wistron driver should be disabled if acpi hotkey enabled.
>> 
>> It is implicitly disabled because it contains DMI ids of 
>known laptops,
>> and its module_init() fails with -ENODEV when used on other hardware,
>> before ever touching the BIOS.
>> 
>> I therefore can't see how it could break anything unless you have
>> explicitly supplied module parameters to override this check.
>On second thought, do you by "found BIOS interfaces" mean "found BIOS
>interfaces when asked to" or "matched the existing Aspire 1500 DMI ID"?

I found this in dmesg:

wistron_btns: BIOS signature found at c00f6920, entry point 000FDC10
input: Wistron laptop buttons as /class/input/input2

>
>Thanks,
>	Mirek
>
