Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317201AbSFKRMO>; Tue, 11 Jun 2002 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSFKRMN>; Tue, 11 Jun 2002 13:12:13 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:42112 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317201AbSFKRML>; Tue, 11 Jun 2002 13:12:11 -0400
Date: Tue, 11 Jun 2002 19:18:09 +0200
Organization: Pleyades
To: afu@fugmann.dhs.org, raul@pleyades.net
Subject: Re: Bandwidth 'depredation' revisited
Cc: linux-kernel@vger.kernel.org
Message-ID: <3D0630D1.mail1QU4CMT6K@viadomus.com>
In-Reply-To: <3D05EEAF.mailZE11URHZ@viadomus.com>
 <3D060FF6.5000409@fugmann.dhs.org>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Anders :)

>To do this you can use ingress scheduler.

    That's the point... I'll give it a try, then.

>tc qdisc add dev eth0 handle ffff: ingress
>tc filter add dev etc0 parent ffff: protocol ip prio 50 u32 \
>         match ip src 0.0.0.0/0 police \
>         rate 232kbit burst 10k drop flowid :1

    OK. Maybe a stupid question: will I need to mark the packages
with iptables in order to get them thru de ingress scheduler :?

>The downside is, that this actually decreases the maximum download
>speed, but you can really feel the difference.

    Don't worry about that. I'll give it a try and compare results.

>IIRC, All this was explained in the Advanced-Routing howto.

    I missed this part, then. Well, I didn't read deeply the
different shapers...

    Thanks a lot :)
    Raúl
