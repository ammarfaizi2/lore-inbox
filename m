Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbUBAVaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbUBAVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:30:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265623AbUBAVaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:30:09 -0500
Message-ID: <401D6FD8.2040406@redhat.com>
Date: Sun, 01 Feb 2004 11:30:00 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031225 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabrice Bellet <fabrice@bellet.info>
CC: fedora-devel-list@redhat.com, linux-kernel@vger.kernel.org,
       Bill Nottingham <notting@redhat.com>, csmith@redhat.com
Subject: Re: Trouble with Cisco Airo MPI350 and kernel-2.6.1+
References: <4014AA49.8050800@redhat.com> <20040127164031.GA13174@bellet.info> <401CCF8A.2010406@redhat.com>
In-Reply-To: <401CCF8A.2010406@redhat.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Togami wrote:
> Fabrice Bellet wrote:
> 
>> Hi Warren,
>>
>> On Sun, Jan 25, 2004 at 07:48:57PM -1000, Warren Togami wrote:
>>
>>> IBM Thinkpad T41
>>> Cisco Airo MPI350 802.11b Wireless
>>> PCIID: 0x14b9  0xa504
>>> Kernel: Fedora rawhide 2.6.1-1.57 (Based on 2.6.2-rc1)
>>>
>>> http://bellet.info/~bellet/laptop/t40.html#wireless
>>> http://bellet.info/~bellet/laptop/airo.c-2.6.1-mm2.diff
>>> airo.ko does not support this Airo device, but with the addition of 
>>> this patch it recognizes the device.
>>
>>
>>
> [SNIP]
> Used the ACU tool under Windows XP for flashing the firmware.  The 
> newest firmware version that operates with your driver is:
> 5.00.03
> 
> Perhaps mention within a comment and/or config Help of your patch that 
> the newest supported firmware is 5.00.03?  That would save people like 
> me a lot of time in the future...
> 

Are these many errors normal?

[root@ibmlaptop etc]# iwconfig eth1
Warning: Driver for device eth1 has been compiled with version 16
of Wireless Extension, while this program is using version 15.
Some things may be broken...

eth1      IEEE 802.11-DS  ESSID:"apophis"  Nickname:"ibmlaptop"
           Mode:Managed  Frequency:2.412GHz  Access Point: 00:0C:41:75:D4:02
           Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
           Retry limit:16   RTS thr:off   Fragment thr:off
           Encryption key:****-****-**   Security mode:open
           Power Management:off
           Link Quality:30/0  Signal level:-70 dBm  Noise level:-98 dBm
           Rx invalid nwid:59  Rx invalid crypt:0  Rx invalid frag:0
           Tx excessive retries:1  Invalid misc:4900   Missed beacon:3

[root@ibmlaptop etc]# ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:02:8A:DF:50:FC
           inet addr:192.168.1.103  Bcast:192.168.1.255  Mask:255.255.255.0
           inet6 addr: fe80::202:8aff:fedf:50fc/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:905 errors:655 dropped:0 overruns:0 frame:655
           TX packets:699 errors:33 dropped:0 overruns:0 carrier:0
           collisions:30 txqueuelen:1000
           RX bytes:439321 (429.0 Kb)  TX bytes:118979 (116.1 Kb)
           Interrupt:11 Base address:0x8000
