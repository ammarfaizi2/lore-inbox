Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTKRMvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 07:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTKRMvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 07:51:10 -0500
Received: from mail1.btignite.se ([194.213.69.45]:32784 "HELO
	mail2.btignite.se") by vger.kernel.org with SMTP id S261563AbTKRMvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 07:51:07 -0500
Message-ID: <3FBA15B7.7030906@lanil.mine.nu>
Date: Tue, 18 Nov 2003 13:51:03 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031117 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pontus Fuchs <pof@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
References: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
In-Reply-To: <1069153340.2200.28.camel@dhcp-225.mlm.tactel.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pontus Fuchs wrote:
> Hi,
> 
> Since some vendors refuses to release specs or even a binary
> Linux-driver for their WLAN cards I desided to try to solve it myself by
> making a kernel module that can load Ndis (windows network driver API)
> drivers. I'm not trying to implement all of the Ndis API but rather
> implement the functions needed to get these unsupported cards working.

Sounds like a plan!

Ok, here we go with my intel PRO/2100 (those found in centrino laptops).
The drivers are taken from Acers homepage (I have an Travelmate 800)

[lspci]
02:04.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)

[lspci -n]
02:04.0 Class 0280: 8086:1043 (rev 04)

[utils/loaddriver 8086 1043 w70n51.sys w70n51.inf]
Calling putdriver ioctl
Unable to put driver (check dmesg for more info): Invalid argument

[dmesg]
Putting driver size 2479104
Unknown symbol: ntoskrnl.exe:strlen
Unknown symbol: ntoskrnl.exe:memcpy
Unknown symbol: ntoskrnl.exe:memset
Unknown symbol: HAL.dll:WRITE_PORT_ULONG
Unknown symbol: HAL.dll:READ_PORT_ULONG
Unknown symbol: NDIS.SYS:NdisResetEvent
Unknown symbol: NDIS.SYS:NdisInitializeString
Unknown symbol: NDIS.SYS:NdisMSleep
Unknown symbol: NDIS.SYS:NdisUnchainBufferAtBack
Unknown symbol: NDIS.SYS:NdisQueryBufferSafe
Unknown symbol: NDIS.SYS:NdisGetFirstBufferFromPacketSafe
Unknown symbol: NDIS.SYS:NdisUnchainBufferAtFront
Unable to prepare driver

-- 
Christan Axelsson
smiler@lanil.mine.nu


