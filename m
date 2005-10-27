Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVJ0Uyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVJ0Uyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVJ0Uyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 16:54:44 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:31653 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932243AbVJ0Uyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 16:54:43 -0400
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
X-Message-Flag: Warning: May contain useful information
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	<1130446278.5416.10.camel@blade>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 27 Oct 2005 13:54:37 -0700
In-Reply-To: <1130446278.5416.10.camel@blade> (Marcel Holtmann's message of
 "Thu, 27 Oct 2005 22:51:18 +0200")
Message-ID: <52ek66wuia.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 27 Oct 2005 20:54:38.0846 (UTC) FILETIME=[A55611E0:01C5DB38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > BIOS-provided physical RAM map:
    >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
    >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
    >  BIOS-e820: 00000000000edbb0 - 0000000000100000 (reserved)
    >  BIOS-e820: 0000000000100000 - 00000000cec11000 (usable)
    >  BIOS-e820: 00000000cec11000 - 00000000cee12000 (ACPI NVS)
    >  BIOS-e820: 00000000cee12000 - 00000000cf68f000 (usable)
    >  BIOS-e820: 00000000cf68f000 - 00000000cf6e9000 (ACPI NVS)
    >  BIOS-e820: 00000000cf6e9000 - 00000000cf6ed000 (usable)
    >  BIOS-e820: 00000000cf6ed000 - 00000000cf6ff000 (ACPI data)
    >  BIOS-e820: 00000000cf6ff000 - 00000000cf700000 (usable)

If that's the full e820 map, then I guess the question is why did the
BIOS not tell you about any memory above 0xcf700000?

And I have no idea why it wouldn't.  For comparison, here's an AMD64
system I have with 4 GB of RAM.  Notice how it put a big chunk of RAM
above 4G:

 BIOS-e820: 0000000000000000 - 0000000000098800 (usable)
 BIOS-e820: 0000000000098800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bff20000 (usable)
 BIOS-e820: 00000000bff20000 - 00000000bff2a000 (ACPI data)
 BIOS-e820: 00000000bff2a000 - 00000000bff80000 (ACPI NVS)
 BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
 BIOS-e820: 00000000d8800000 - 00000000d8800400 (reserved)
 BIOS-e820: 00000000d8801000 - 00000000d8801400 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)

 - R.
