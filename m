Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbVLFIal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbVLFIal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 03:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbVLFIal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 03:30:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46035 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751690AbVLFIak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 03:30:40 -0500
Message-ID: <43954C25.5070809@volny.cz>
Date: Tue, 06 Dec 2005 09:30:29 +0100
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [git pull 02/14] Add Wistron driver
References: <3ACA40606221794F80A5670F0AF15F840A53FC2D@pdsmsx403> <439548B5.9030603@volny.cz>
In-Reply-To: <439548B5.9030603@volny.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miloslav Trmac wrote:
> Yu, Luming wrote:
>>>> I just tested module wistron_btn on  one Acer Aspire laptop after 
>>>> adding one dmi entry.  The wistron_btn found BIOS interfaces.

>>>If your laptop provides the hotkey events via ACPI, simply don't use
>>>wistron_btns.
>>
>>wistron driver should be disabled if acpi hotkey enabled.
> 
> It is implicitly disabled because it contains DMI ids of known laptops,
> and its module_init() fails with -ENODEV when used on other hardware,
> before ever touching the BIOS.
> 
> I therefore can't see how it could break anything unless you have
> explicitly supplied module parameters to override this check.
On second thought, do you by "found BIOS interfaces" mean "found BIOS
interfaces when asked to" or "matched the existing Aspire 1500 DMI ID"?

Thanks,
	Mirek
