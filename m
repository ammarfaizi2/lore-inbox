Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbQLKJ44>; Mon, 11 Dec 2000 04:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLKJ4r>; Mon, 11 Dec 2000 04:56:47 -0500
Received: from web1.clubnet.net ([206.126.128.3]:62728 "EHLO web1.clubnet.net")
	by vger.kernel.org with ESMTP id <S129688AbQLKJ4c>;
	Mon, 11 Dec 2000 04:56:32 -0500
Message-ID: <000901c06354$7732e240$598d7ece@snowline.net>
From: "Eddy" <edmc@snowline.net>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E144syy-0005sE-00@the-village.bc.nu>
Subject: Re: Linux 2.2.18 almost...
Date: Mon, 11 Dec 2000 01:26:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

did we lose ip=autoconf. I see dhcp and arp transmitting infinitely. I was
able to boot only after completely entering nfsroot= and ip= boot commands.

2.2.17 worked thusley.

root=/dev/nfs ether=0,0,eth0

2.2.18-pre26 works only

root=/dev/nfs
nfsroot=192.168.50.11:/tftpboot/191.168.50.2,rsize=8192,wsize=8192
ip=192.168.50.2:192.168.50.11:::Eddys486:eth0:off ether=0,0,eth0

for some reason

root=/dev/nfs ether=0,0,eth0   gives this result

Dec 10 22:48:24 Eddys dhcpd: BOOTREQUEST from 00:50:ba:05:7b:fb via eth0
Dec 10 22:48:24 Eddys dhcpd: BOOTREPLY for 192.168.50.2 to eddys486
(00:50:ba:05:7b:fb) via eth0
Dec 10 22:48:26 Eddys dhcpd: BOOTREQUEST from 00:50:ba:05:7b:fb via eth0
Dec 10 22:48:26 Eddys dhcpd: BOOTREPLY for 192.168.50.2 to eddys486
(00:50:ba:05:7b:fb) via eth0
Dec 10 22:48:29 Eddys dhcpd: BOOTREQUEST from 00:50:ba:05:7b:fb via eth0
Dec 10 22:48:29 Eddys dhcpd: BOOTREPLY for 192.168.50.2 to eddys486
(00:50:ba:05:7b:fb) via eth0
Dec 10 22:48:36 Eddys dhcpd: BOOTREQUEST from 00:50:ba:05:7b:fb via eth0
Dec 10 22:48:36 Eddys dhcpd: BOOTREPLY for 192.168.50.2 to eddys486
(00:50:ba:05:7b:fb) via eth0
Dec 10 22:48:47 Eddys dhcpd: BOOTREQUEST from 00:50:ba:05:7b:fb via eth0
Dec 10 22:48:47 Eddys dhcpd: BOOTREPLY for 192.168.50.2 to eddys486
(00:50:ba:05:7b:fb) via eth0

and

root=/dev/nfs ip=both ether=0,0,eth0     gives this result

Dec 10 22:50:52 Eddys dhcpd: DHCPDISCOVER from 00:50:ba:05:7b:fb via eth0
Dec 10 22:50:52 Eddys dhcpd: DHCPOFFER on 192.168.50.2 to 00:50:ba:05:7b:fb
via eth0
Dec 10 22:50:55 Eddys dhcpd: DHCPDISCOVER from 00:50:ba:05:7b:fb via eth0
Dec 10 22:50:55 Eddys dhcpd: DHCPOFFER on 192.168.50.2 to 00:50:ba:05:7b:fb
via eth0
Dec 10 22:51:00 Eddys dhcpd: DHCPDISCOVER from 00:50:ba:05:7b:fb via eth0
Dec 10 22:51:00 Eddys dhcpd: DHCPOFFER on 192.168.50.2 to 00:50:ba:05:7b:fb
via eth0
Dec 10 22:51:09 Eddys dhcpd: DHCPDISCOVER from 00:50:ba:05:7b:fb via eth0
Dec 10 22:51:09 Eddys dhcpd: DHCPOFFER on 192.168.50.2 to 00:50:ba:05:7b:fb
via eth0


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
