Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTLKCX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbTLKCX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:23:56 -0500
Received: from [202.37.96.11] ([202.37.96.11]:52417 "EHLO
	gatekeeper.tait.co.nz") by vger.kernel.org with ESMTP
	id S264311AbTLKCXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:23:50 -0500
Date: Thu, 11 Dec 2003 15:24:40 +1300
From: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Subject: How to publish arp info correctly?
To: linux-kernel@vger.kernel.org
Message-id: <3FD7D568.3050406@tait.co.nz>
Organization: Tait Electronics Ltd
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we declare an IP address to be published ie. arp -v -i eth0 -Ds 
172.25.207.1 eth0 pub
And if we do the ping 172.25.207.1 the tcpdump showing that arp request 
arrives but the box happily ignores it.
There is not publishing occurs, though arp cache has:

/ # arp
Address                 HWtype  HWaddress           Flags 
Mask            Iface
tuna                    ether   00:04:75:E7:1B:93   
C                     eth0
172.25.140.1            ether   08:00:20:7D:4D:9A   
C                     eth0
172.25.207.1            *       *                   
MP                    eth0

/ # cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     
Device
172.25.140.8     0x1         0x2         00:04:75:E7:1B:93     *        eth0
172.25.207.1     0x1         0xc         00:00:00:00:00:00     *        eth0

Could anybody please tell me is this the problem with the kernel we are 
using - 2.4.22 or something else.

Thank you

