Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUDNDk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 23:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDNDk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 23:40:59 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:37832 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S263568AbUDNDkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 23:40:55 -0400
From: plazmcman@softhome.net
To: linux-kernel@vger.kernel.org
Subject: 2.6.x DMA ALI chipset bugs
Date: Tue, 13 Apr 2004 21:40:54 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [209.77.201.156]
Message-ID: <courier.407CB2C6.000053A7@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old IBM ThinkPad (266MHz) with an ALi chipset.  lspci -v | grep -i 
ali reports: 

[addr] Host bridge: ... M1531
 Subsystem: ... M1531
[addr] ISA bridge: ... M1533
 Subsystem: ...M1533
[addr] IDE interface: ... M5229
[addr] Bridge: ... M7101 

Under kernel 2.4.22, DMA worked fine (~9MB/s hda).  With 2.6.(0,3,4,5), the 
machine won't work with DMA enabeled at boot. Kernel panics due to "can't 
find init", and stuff like "can't execute /etc/rc.d/rc.S", or 
"/sbin/agetty", etc. 

I _do_ have kernel support (built-in) for ALiM15x3. I can boot up the 
computer (kernel argument ide=nodma), and then attempt to turn DMA on - it 
will sometimes succed, _but_ there is no performance gain (~4MB/s - ugh). 

Any workarounds, patches, help? 

Thanks,
Brannon Klopfer
