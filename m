Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbUKXStX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbUKXStX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUKXSsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:48:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26849 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262797AbUKXSnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:43:06 -0500
Date: Wed, 24 Nov 2004 12:12:00 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ole Laursen <olau@cs.aau.dk>, Linux kernel <linux-kernel@vger.kernel.org>,
       d507a@cs.aau.dk
Subject: Re: Isolating two network processes on same machine
In-Reply-To: <Pine.LNX.4.61.0411241203030.4312@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0411241209310.4391@chaos.analogic.com>
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>  <Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
 <1101314296.1761.18.camel@krustophenia.net> <Pine.LNX.4.61.0411241203030.4312@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004, linux-os wrote:

> On Wed, 24 Nov 2004, Lee Revell wrote:
>
>> On Wed, 2004-11-24 at 11:23 -0500, linux-os wrote:
>>> I was going to say, set the netmask small enough so that both
>>> machines are on different networks and set default routes to
>>> your gateway.... But there is a bug somewhere that doesn't
>>> allow a netmask of anything but 0 in the last byte.
>>> 
>> 
>> Really?  That would be a horrible bug.  How about some references?
>> 
>> Lee
>> 
>
> Huh? Try it........
>
> Script started on Wed 24 Nov 2004 12:03:43 PM EST
> # ifconfig eth1 1.2.3.4 netmask 255.255.255.7
> SIOCSIFNETMASK: Invalid argument
> # ifconfig eth1 1.2.3.4 netmask 255.255.255.0
> # exit
>
> Script done on Wed 24 Nov 2004 12:04:42 PM EST
>


Well I guess you can set it to:

eth1      Link encap:Ethernet  HWaddr 00:10:5A:27:7B:16
           inet addr:1.3.4.5  Bcast:1.255.255.255  Mask:255.255.255.252
                                                                    ^^^
           inet6 addr: fe80::210:5aff:fe27:7b16/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:68120 errors:0 dropped:0 overruns:0 frame:0
           TX packets:5 errors:0 dropped:0 overruns:0 carrier:3
           collisions:0 txqueuelen:1000
           RX bytes:4383953 (4.1 Mb)  TX bytes:378 (378.0 b)
           Interrupt:22 Base address:0xbc00


That should ne able to isolate the two machines on the same wire.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
