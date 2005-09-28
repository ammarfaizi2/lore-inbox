Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbVI1J6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbVI1J6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVI1J6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:58:35 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:60523 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750852AbVI1J6f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:58:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iQFyHt156KXXsmTuIQhNRWlU/QKMvjdR4vbhe2GAD3YJkJSMDt7qBpRIIQ2NxNLdecM+ivPdeROiQQlKHZPgADVTSEr61/Kptu2P31iiqUFohjBR/TTkhkTtvHLLydkafpWmmL28BpRi/euJNW6TJb7gw+xQJL9N0Oqxoo786DI=
Message-ID: <6278d222050928025865d8968c@mail.gmail.com>
Date: Wed, 28 Sep 2005 10:58:32 +0100
From: Daniel J Blueman <daniel.blueman@gmail.com>
Reply-To: Daniel J Blueman <daniel.blueman@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, jpiszcz@lucidpixels.com
Subject: Re: TCP=828mbps, UDP=1mbps? (both running 2.6.13.2)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

When running iperf in UDP mode (-u), you must specify a bandwidth, ie:

server$ iperf -s -u
client$ iperf -c server -u -b 1000M

Justin Piszcz wrote:
> Any idea why with TCP I get 828 megabits on my gigabit connection but only
> 1.05 megabits with UDP?
>
> Using iperf to benchmark.
>
> TCP
> ------------------------------------------------------------
> Server listening on TCP port 5001
> TCP window size: 85.3 KByte (default)
> ------------------------------------------------------------
> [  4] local 192.168.1.12 port 5001 connected with 192.168.1.253 port
> 48853
> [  4]  0.0-35.1 sec  3.38 GBytes    828 Mbits/sec
>
>
> UDP
> ------------------------------------------------------------
> Server listening on UDP port 5001
> Receiving 1470 byte datagrams
> UDP buffer size:   101 KByte (default)
> ------------------------------------------------------------
> [  3] local 192.168.1.12 port 5001 connected with 192.168.1.253 port
> 32773
> [  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec  0.043 ms    0/  893 (0%)
>
>
> p34:~$ netstat -i
> Kernel Interface table
> Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR
> Flg
> eth0   1500 0   1266337      0      0      0  2588651      0      0      0
> BMRU
> eth1   1500 0      2358      0      0      0     2229      0      0      0
> BMRU
> eth2   1500 0     39706      0      0      0     5747      0      0      0
> BMNRU
> lo    16436 0       184      0      0      0      184      0      0      0
> LRU
>
> box2:~$ netstat -i
> Kernel Interface table
> Iface   MTU Met   RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR
> Flg
> eth0   1500 0   2955176      0      0      0  3696501      0      0      0
> BMRU
> lo    16436 0       612      0      0      0      612      0      0      0
> LRU
___
Daniel J Blueman
