Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUKVDsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUKVDsW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 22:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKVDsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 22:48:22 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:4779 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261913AbUKVDpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 22:45:36 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-Id: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Nov 2004 14:44:59 +1100
To: "Jeff V. Merkey" <jmerkey@devicelogics.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning
  and sickness
Cc: "Jeff V. Merkey" <jmerkey@devicelogics.com>, linux-kernel@vger.kernel.org,
       jmerkey@drdos.com
In-Reply-To: <419E6E5D.2000709@devicelogics.com>
References: <419E6B44.8050505@devicelogics.com>
 <419E6B44.8050505@devicelogics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

you're using commodity x86 hardware.  what do you expect?

while the speed of PCs has increased significantly, there are still 
significant bottlenecks when it comes to PCI bandwidth, PCI arbitration 
efficiency & # of interrupts/second.
linux ain't bad -- but there are other OSes which still do slightly better 
given equivalent hardware.

with a PC comes flexibility.
that won't match the speed of the FPGAs in a Spirent Smartbits, Agilent 
RouterTester, IXIA et al ...


cheers,

lincoln.

At 09:06 AM 20/11/2004, Jeff V. Merkey wrote:

>Additionally, when packets sizes 64, 128, and 256 are selected, pktgen is 
>unable to achieve > 500,000 pps (349,000 only on my system).
>A Smartbits generator can achieve over 1 million pps with 64 byte packets 
>on gigabit.  This is one performance
>issue for this app.  However, at 1500 and 1048 sizes, gigabit saturation 
>is achievable.
>Jeff
>
>Jeff V. Merkey wrote:
>
>>
>>With pktgen.o configured to send 123MB/S on a gigabit on a system using 
>>pktgen set to the following parms:
>>
>>pgset "odev eth1"
>>pgset "pkt_size 1500"
>>pgset "count 0"
>>pgset "ipg 5000"
>>pgset "src_min 10.0.0.1"
>>pgset "src_max 10.0.0.254"
>>pgset "dst_min 192.168.0.1"
>>pgset "dst_max 192.168.0.254"
>>
>>After 37 hours of continual packet generation into a gigabit regeneration 
>>tap device,
>>the server system console will start to respawn the INIT process about 
>>every 10-12
>>hours of continuous packet generation.
>>
>>As a side note, this module in Linux is extremely useful and the "USE 
>>WITH CAUTION" warnings
>>are certainly will stated.  The performance of this tool is excellent.
>>
>>Jeff

