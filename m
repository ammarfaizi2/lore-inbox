Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTDOO3d (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDOO3d 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:29:33 -0400
Received: from [195.228.112.1] ([195.228.112.1]:1063 "HELO
	goliat.otphazibank.hu") by vger.kernel.org with SMTP
	id S261545AbTDOO3a (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 10:29:30 -0400
Message-ID: <3E9C19A2.1040206@dell633.otpefo.com>
Date: Tue, 15 Apr 2003 16:39:30 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HIGHMEM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a 
newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux 
kernel uses about 500MB less memory in the newer machine.

See /var/log/boot.msg on the old one:

<4>Linux version 2.4.20 (root@dell632) (gcc version 2.95.3 20010315
(SuSE)) #4 SMP Fri Jan 10 12:07:00 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 00000000fbffe000 (usable)
<4> BIOS-e820: 00000000fbffe000 - 00000000fc000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>3135MB HIGHMEM available.
<5>896MB LOWMEM available.

and on the new one:

<4>Linux version 2.4.20 (root@alfa) (gcc version 2.95.3 20010315 (SuSE))
#10 SMP Fri Mar 28 15:40:45 CET 2003
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 0000000000100000 - 00000000dfff0000 (usable)
<4> BIOS-e820: 00000000dfff0000 - 00000000dfffec00 (ACPI data)
<4> BIOS-e820: 00000000dfffec00 - 00000000dffff000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
<4> BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
<5>2687MB HIGHMEM available.
<5>896MB LOWMEM available.


There is a big hole between 00000000dffff000 and 00000000fec00000, which
is not used on the new machine. What can I do?

Thanks for your help.

Tibor


------------------------------------------------------------------------
Tibor Nagy
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------


