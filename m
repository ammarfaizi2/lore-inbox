Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUHVNNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUHVNNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHVNNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:13:31 -0400
Received: from wasp.net.au ([203.190.192.17]:23732 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266596AbUHVNNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:13:15 -0400
Message-ID: <41289C0B.7010805@wasp.net.au>
Date: Sun, 22 Aug 2004 17:13:47 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josan Kadett <corporate@superonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level
References: <S266616AbUHVJsa/20040822094830Z+232@vger.kernel.org>
In-Reply-To: <S266616AbUHVJsa/20040822094830Z+232@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josan Kadett wrote:
> I am still persistent on the fact that NAT should work with this sense.
> 
> I just enable NAT with the following command
> 
> iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to 192.168.1.5
> 
> This IP 192.168.1.5 is our patched linux server which is allowed to acccess
> 192.168.1.77
> 
> Now all protocols in the linux system is working fine as ever, and even ping
> sent to 192.168.77.1 returns from 192.168.77.1 that is visible in the
> presumably lowest layer of network stack (as tcpdump also sees it that way).
> 
> However; the client on the interface eth0 which has the IP address of
> 192.168.0.30 gets its IP address translated to 192.168.1.5, the ping is sent
> and a response is received (tcpdump shows it)
> 

Are you trying to ping 192.168.77.1 from 192.168.0.30?

Can you give me an iptables -L -n -t nat, ifconfig and route -n from the patched box and also route 
-n and ifconfig from the dummy client at 192.168.0.30 so I can try and get a handle on what you are 
doing and how it all is supposed to work?

