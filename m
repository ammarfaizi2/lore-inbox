Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbQKPScx>; Thu, 16 Nov 2000 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129230AbQKPScn>; Thu, 16 Nov 2000 13:32:43 -0500
Received: from [151.17.201.167] ([151.17.201.167]:30834 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S129211AbQKPScc>;
	Thu, 16 Nov 2000 13:32:32 -0500
Message-ID: <3A1420FD.528D2C41@teamfab.it>
Date: Thu, 16 Nov 2000 19:01:33 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chip Schweiss <chip@innovates.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre21 - IP kernel level autoconfiguration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seem somewhere between 2.2.17 and the current 2.2.18 kernel, IP 
> kernel level autoconfiguration has been broken. Upon kernel loading 
> the Ethernet card is detected and loaded properly, but the bootp code 
> never seems to be executed and mounting the root partion via NFS then 
> fails from lack of IP configuration. 
> I haven't had any luck tracing down the root of this problem. 
> Anyone else experience this problem or have a patch to fix it? 

Hi!

I've the same behavior here:

 server kernel : 2.2.17
 dhcpd         : 2.0b1pl29
 client kernel : 2.2.18-21
 client cmdline: root=/dev/nfs nfsroot=/foo/bar ip=bootp

After some quick tests seem that if you want bootp
you _need_ to compile the client's kernel with _only_ bootp,
if you have also dhcp, it doesn't work :(

Dhcp into kernel is COOL and I hope that someone is
porting on 2.4 ;), doesn't seem that hard

hope this help,
luca
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
