Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280678AbRK1VMy>; Wed, 28 Nov 2001 16:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280728AbRK1VMo>; Wed, 28 Nov 2001 16:12:44 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.34]:17839 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S280697AbRK1VMa>; Wed, 28 Nov 2001 16:12:30 -0500
Message-ID: <3C055334.6030007@zipkid.com>
Date: Wed, 28 Nov 2001 22:12:20 +0100
From: ZipKid <stefan@zipkid.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-us
MIME-Version: 1.0
To: Adrian Daminato <adrian@tucows.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hiding arp for server farms
In-Reply-To: <3C0522C4.E5321021@tucows.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Daminato wrote:

>Okay, I've seen similar posts to this, but none of them provide a solution that
>I can use.
>
>I'm running several 2.2 machines behind a Radware load balancer, which uses
>something called "local triangulation".  Basically the Radware responds to ARP
>requests for the IP of the farm, passes the packet to one of the servers, and
>the server responds directly to the client.  Each server has an aliased
>interface on the loopback for the IP of the farm, and
>/proc/sys/net/ipv4/conf/all/hidden and lo/hidden are set to 1.  That works,
>great, no problems.
>
>Now, introduce an unpatched 2.4.x kernel.  The hidden option no longer exists,
>and for ease of operating a production environment, we prefer to use stock
>kernels straight from kernel.org, no patches at all.  I've tried many different
>suggestion from the list:
>
>1) ifconfig eth0 -arp
>    We have over 60 servers on the subnet these farms are on, and they need to
>be able to communicate with each other.  When I do this, I can't talk to other
>servers on the network, and keeping an /etc/ethers file up to date is a daunting
>task, and not practical.
>
>2) arp_filter
>    I tried using it in a couple of ways, but there doesn't appear to be very
>

I have tested this setup and had the same problems on a 2.4.12 kernel. I 
tried out a few things
and could not resolve this issue. Fortunately for me the client is 
running solaris and that does
not have this bug.
Sorry but I have no solution...

Stefan - ZipKid - Goethals


