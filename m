Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUKZTMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUKZTMI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKZTMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:12:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:65215 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261867AbUKZTLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:11:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Date: Fri, 26 Nov 2004 08:53:18 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575A4EB08@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] Re: Fw: ACPI bug causes cd-rom lock-ups (2.6.10-rc2)
Thread-Index: AcTTJ842mxR6zfHfQOidgnZoRUr8DQAKXN2g
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Stas Sergeev" <stsp@aknet.ru>, "Brown, Len" <len.brown@intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "ACPI Developers" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 26 Nov 2004 00:53:20.0396 (UTC) FILETIME=[52D92CC0:01C4D352]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Len Brown wrote:
>> CONFIG_PNP_ACPI=n should workaround it too then, I expect.
>Yes. Log attached.
>
>> Please apply this debug patch to the failing kernel
>> and send along the dmesg.
>Done. Attached are 2 logs: one of
>the functional kernel due to disabled
>PNP_ACPI, another one of a broken.
>Both are the -rc2-mm2 with your patch.
Thanks the message. Looks like the system claims IRQ 9, 10, 11 are
possible legacy IRQs. Selecting a small value for ISA IRQ penalty will
solve the issue.
Will discuss with Len which parameter should be selected.

Thanks,
Shaohua
