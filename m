Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316577AbSE0R3a>; Mon, 27 May 2002 13:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSE0R33>; Mon, 27 May 2002 13:29:29 -0400
Received: from pD952A637.dip.t-dialin.net ([217.82.166.55]:56514 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316577AbSE0R32>; Mon, 27 May 2002 13:29:28 -0400
Date: Mon, 27 May 2002 11:27:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Abdij Bhat <Abdij.Bhat@kshema.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Prasad HA <prasad@kshema.com>, Prakash P <Prakash@kshema.com>
Subject: Re: IP Forwarding Problem
In-Reply-To: <91A7E7FABAF3D511824900B0D0F95D10137099@BHISHMA>
Message-ID: <Pine.LNX.4.44.0205271123490.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 May 2002, Abdij Bhat wrote:
>  I am trying to deploy IP Forwarding on an embedded system running on Linux
> [ Kernel > 2.4 ] with mips target.
>  I do a "echo "1" > /proc/sys/net/ipv4/ip_forward" to enable and "echo "0" >
> /proc/sys/net/ipv4/ip_forward" to disable the IP Forwarding feature.
> 
>  The hardware setup i have is as below
> 
> 1. Linux PC [ Ref PC A ] with eth0 IP Address say 192.168.100.5
> 2. Linux PC [ Ref PC B ] with eth0 IP Address say 192.168.101.5
> 3. The embedded target has 2 NIC's. eth0 IP Address is 192.168.100.6 and
> eth1 IP Address is 192.168.101.6.
> 4. A hub connecting subnet 100 machines
> 5. A hub connecting subnet 101 machines
> 
>  I setup the default gateways on both the Reference PC's to reflect their
> own IP Address. Each of the Ref PC's can ping to the machines on their
> subnet.
>  But when i ping Ref PC A to Ref PC B; the give the error "Destination host
> is unreachable".
> 
>  I tried to resolve the problem and found a few info on the net. Based on
> that i found that
> 1. there was no /etc/sysconfig directory on the target embedded system 
> 2. there was no /etc/sysconfig/network-scripts directory
> 3. no /etc/sysconfig/network-scripts/ifcfg-eth0, eth1, eth0:1 and eth1:0
> files 
> 4. there was no /etc/sysconfig/network file

They are altogether used by RedHat compatible startup scripts, and should 
not be necessary on embedded systems if your interfaces are ifconfig'ed. 
Is your routing table (route -n) set up correctly?

Try tracerouting from ref host A to ref host B while running tcpdump on 
the embedded penguin.

However, I don't believe this is an issue to linux-kernel, we should 
consider private talks...

>  I created all of the above [ i have pasted the contents of each file below
> ]. Yet i get the same error. Can somebody tell what am i not doing or what
> am i doing wrong?

You're expecting files to be applied.

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.


