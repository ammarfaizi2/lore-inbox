Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbUBYSKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUBYSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:10:16 -0500
Received: from smtp-2.vancouver.ipapp.com ([216.152.192.208]:58377 "EHLO
	axion.net") by vger.kernel.org with ESMTP id S261513AbUBYSKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:10:07 -0500
Message-ID: <403CE4E4.9010608@axion.net>
Date: Wed, 25 Feb 2004 10:09:40 -0800
From: Patrick Richard <patr@axion.net>
User-Agent: Mozilla Thunderbird 0.5 (Macintosh/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e1000 only works in 2.6.3 with UP kernel ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
X-Country: CA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been struggling to get the e1000 driver working _at all_ in 
2.6.3. It works fine under 2.4.xx (same machine). This is all on an ASUS 
P4C800-E deluxe, using onboard e1000 and P4 with HT enabled.

I have tried with / without apic, ACPI (boot option and compiled in), 
SCSI, libata. Depending on what I have configured in the kernel, it will 
stop at various places, for example, sometimes we will get a solid 
lockup when running ifconfig (with ACPI and apic enabled), whereas 
elsewhere, (no ACPI compiled in, i.e. not just disabled on boot args) it 
will lock not on ifconfig, but will on first attempy to use the card 
(i.e. ping thyself).

Anyhow, the *only* configuration I have managed to get working is on a 
UP-built kernel, built with SMP disabled. Despite having an affect on 
where it would lock up in the SMP kernel, it seemed to not matter if 
APIC or ACPI or libata etc. was enabled or not in the UP kernel. If I 
disabled the SMP at boot with bootargs, it still didn't work.

Is anyone else seeing similar problems ? Seems like an interrupt/ACPI 
type of thing to me based on what is affecting it but what do I know.

Does anyone have this working on an SMP kernel/machine with this 
motherboard ? Is this a mis-config on my part ? Like I said it works 
fine in 2.4 and in UP kernel.

-Pat

