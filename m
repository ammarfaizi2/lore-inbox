Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267879AbUHPTKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267879AbUHPTKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUHPTKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:10:01 -0400
Received: from maximus.kcore.de ([213.133.102.235]:28756 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S267879AbUHPTJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:09:46 -0400
Message-ID: <41210649.4090008@gmx.net>
Date: Mon, 16 Aug 2004 21:08:57 +0200
From: Oliver Feiler <kiza@gmx.net>
User-Agent: Mozilla Thunderbird 0.7 (Macintosh/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com> <1092678734.23057.18.camel@dhcppc4> <41210098.4080904@gmx.net>
In-Reply-To: <41210098.4080904@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------040502030605050701020805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040502030605050701020805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Oliver Feiler wrote:
> 
> 
> Ok, I've turned on the IOAPIC and it seems to work perfectly fine. 
> Except for that IRQ 255 thing I've noticed no oddities. Thanks for the 
> hint. :)

No, not quite. After about 30 minutes of uptime and a moderate load of 
eth0 (100-200KB/s constant data flow) it happened again. :(

Aug 16 21:03:13 spot kernel: eth0: Tx timed out, lost interrupt? 
TSR=0x3, ISR=0x97, t=36.
Aug 16 21:03:15 spot kernel: eth0: Tx timed out, lost interrupt? 
TSR=0x3, ISR=0x3, t=141.
Aug 16 21:03:23 spot kernel: eth0: Tx timed out, lost interrupt? 
TSR=0x3, ISR=0x3, t=545.
[repeating endlessly]

I've booted a kernel without APIC and IOAPIC compiled and it works again.

I'm attaching a dmesg from a boot with IOAPIC enabled. I don't really 
know where to look for the problem here. The interrupt counter for the 
IRQ eth0 is using (a Realtek 8029 chipset) is growing significantly 
after a while. And after a while is seems to get stuck (Tx timed out). 
"ifconfig eth0 down" and "up" again did nothing. Sometimes it seems to 
fix such network problems.

cu
	Oliver


--------------040502030605050701020805
Content-Type: application/x-gzip; x-mac-type="0"; x-mac-creator="0";
 name="dmesg-2.4.27-ioapic.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg-2.4.27-ioapic.gz"

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
LVE9+D8YmKX8P9E6zq31MAAA
--------------040502030605050701020805--
