Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUL2Qwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUL2Qwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 11:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUL2Qwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 11:52:46 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:43470 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261305AbUL2Qwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 11:52:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ipleLpIy3G3lY3mtU1odVpVcPJ+8rLXVt+BDhFSmzLgcpOmcOBITZXKJwCy554I/UyEUQV0OFjM0CBh+9VDkohjL0Q8IQ6H/aYDGekWwjIL7hcxEwEvELKbyhuaZrMqZGAYpHEqGtUwJEgdydnK85NEauWey8ymcGSiYrREoD3s=
Message-ID: <41D2E0D2.1020409@gmail.com>
Date: Wed, 29 Dec 2004 17:52:34 +0100
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: device mapper & cryptsetup error and   intelfb
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1)
Dec 29 17:42:41 localhost kernel: device-mapper: crypt: Error allocating 
crypto tfm
Dec 29 17:42:42 localhost kernel: device-mapper: error adding target to 
table
Dec 29 17:42:47 localhost udev[18896]: removing device node '/dev/dm-0'

invoked with command:

losetup /dev/loop0 /home/mb/fs1&&cryptsetup create crloop /dev/loop0 && 
mount /dev/mapper/crloop /media/crypted

2)

i also get a plenty of  such messages

intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 488, 0
intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 792, 80
intelfb: intelfb_check_var: accel_flags is 1
intelfb: the cursor was killed - restore it !!
intelfb: size 8, 16   pos 184, 752

Is it normal behaviour ?


hardware info:

0000:00:02.0 VGA compatible controller: Intel Corp. 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03)
thats from lspci
and lspci -v

0000:00:02.0 VGA compatible controller: Intel Corp. 
82845G/GL[Brookdale-G]/GE Chipset Integrated Graphics Device (rev 03) 
(prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 0149
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Memory at f6f80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1

Maybe this helps.
