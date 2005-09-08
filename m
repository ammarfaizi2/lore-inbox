Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVIHKrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVIHKrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 06:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbVIHKrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 06:47:17 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:27652 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S964844AbVIHKrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 06:47:16 -0400
Date: Thu, 8 Sep 2005 12:47:10 +0200 (CEST)
From: gl@dsa-ac.de
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [OOPS] vanilla 2.6.13 + "rmmod processor"
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F05@hdsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.63.0509081221440.11341@pcgl.dsa-ac.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F05@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005, Brown, Len wrote:

>> Just booted a 2.6.13 compiled with UP, ACPI, APIC, LAPIC,
>> sensor modules
>> with "nolapic noapic acpi=off".
>
> Huh, I don't see I don't see the processor module checking
> for acpi_disabled anyplace...
>
> I assume the oops goes away when you
> do not boot with "acpi=off"?

Yep. With apic lapic without acpi= thermal (and other ACPI modules) get 
also loaded successfully by hotplug, so, one has to rmmod thermal 
processor, then no Oops. Actually, should it (processor) at all load 
successfully with acpi=off? It is the only module that loads.

>> The processor module was still loaded by
>> the hotplug. On rmmod it Oopsed:
>
> Note other processor rmmod fix here, maybe unrelated:
> http://bugzilla.kernel.org/show_bug.cgi?id=5021

Are you sure it is this bug? Cannot see how those patches can be related 
to rmmod path, it said something about races, which doesn't seem to be the 
case here. I might be wrong, of course.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
