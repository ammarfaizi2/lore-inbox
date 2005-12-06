Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbVLFHgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVLFHgy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVLFHgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:36:54 -0500
Received: from fmr18.intel.com ([134.134.136.17]:29123 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751469AbVLFHgx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:36:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [git pull 02/14] Add Wistron driver
Date: Tue, 6 Dec 2005 15:35:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840A53FC2D@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [git pull 02/14] Add Wistron driver
thread-index: AcX3fHiweQJ4hUSaT8uCoYVc2QEymgCubdFA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Miloslav Trmac" <mitr@volny.cz>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 06 Dec 2005 07:35:36.0751 (UTC) FILETIME=[A624EBF0:01C5FA37]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Yu, Luming wrote:
>> I just tested module wistron_btn on  one Acer Aspire laptop after 
>> adding one dmi entry.  The wistron_btn found BIOS interfaces.
>> One visible error is the bluetooth light won't turn on upon 
>> stroking bluetooth button.
>> Without wistron_btn module, the bluetooth light works.
>>  with acpi enabled, I didn't try acpi disabled)
>> 
>> wistron_btn polls a cmos address to detect hotkey event.  It 
>> is not necessary, because there do have ACPI interrupt 
>triggered upon 
>> hotkeys.
>There are many different laptops using similar interfaces.
>It is a mess :(
>
>If your laptop provides the hotkey events via ACPI, simply don't use
>wistron_btns.

wistron driver should be disabled if acpi hotkey enabled.

>
>> So, my suggestion is to disable this module when ACPI enabled.
>I have a laptop that needs this module (hotkeys are not supported via
>ACPI), but supports ACPI.

 Could you share me acpidump output of your laptop?
Please attach it at :
http://bugzilla.kernel.org/show_bug.cgi?id=5692

