Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317471AbSFKSZ4>; Tue, 11 Jun 2002 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSFKSZ4>; Tue, 11 Jun 2002 14:25:56 -0400
Received: from cpe.atm2-0-1071115.0x50c4d862.boanxx10.customer.tele.dk ([80.196.216.98]:59547
	"EHLO fugmann.dhs.org") by vger.kernel.org with ESMTP
	id <S317471AbSFKSZy>; Tue, 11 Jun 2002 14:25:54 -0400
Message-ID: <3D0640B3.8090308@fugmann.dhs.org>
Date: Tue, 11 Jun 2002 20:25:55 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606 Debian/1.0.0-0pre1v1
MIME-Version: 1.0
To: DervishD <raul@pleyades.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bandwidth 'depredation' revisited
In-Reply-To: <3D05EEAF.mailZE11URHZ@viadomus.com> <3D060FF6.5000409@fugmann.dhs.org> <3D0630D1.mail1QU4CMT6K@viadomus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Anders :)
> 
>>tc qdisc add dev eth0 handle ffff: ingress
>>tc filter add dev etc0 parent ffff: protocol ip prio 50 u32 \
>>        match ip src 0.0.0.0/0 police \
>>        rate 232kbit burst 10k drop flowid :1
 >
> OK. Maybe a stupid question: will I need to mark the packages
> with iptables in order to get them thru de ingress scheduler :?
>
No. You can, but dont need to. The above lines match anything comming from eth0, and
shapes it to 232kbit. Tweak the value to suit your needs.

Anders Fugmann





