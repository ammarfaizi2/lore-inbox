Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293503AbSCOXZF>; Fri, 15 Mar 2002 18:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293508AbSCOXYz>; Fri, 15 Mar 2002 18:24:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293503AbSCOXYh>; Fri, 15 Mar 2002 18:24:37 -0500
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
To: davem@redhat.com (David S. Miller)
Date: Fri, 15 Mar 2002 23:40:21 +0000 (GMT)
Cc: davids@webmaster.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020315.151628.122227750.davem@redhat.com> from "David S. Miller" at Mar 15, 2002 03:16:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16m1J7-00051f-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: David Schwartz <davids@webmaster.com>
>    Date: Fri, 15 Mar 2002 15:13:59 -0800
>    
>    	There is no problem with MD5 that makes it unsuitable for this
>    particular application. A SHA signature would enlarge each packet,
>    further reducing the effective MTU. This would increase the cost of
>    what was intended to be a simple mechanism to solve a specific
>    problem (spoofed SYNs/RSTs).
> 
> Ignoring valid RST frames breaks TCP.

If they don't have the right MD5 frame they are not valid. The RFC came
about because people discovered RST spoofing cisco backbone routers was
a great way to remove unwanted ISP's. Then people discovered that spoofing
icmp df framesizes down to 68 bytes worked anyway and the whole MD5 thing
went to shit.

Later crypto folks showed that MD5 is not always good enough

Finally if you are patient and extremely irritating you can capture BGP
sessions, predict the next time the other end will initiate that sequence
number and do BGP replay games. Fortunately thats extremely hard.

IPSEC has a lot more going for it, but most cisco's still only support the
MD5 stuff. However if you can get/set IP/TCP options in user space you
could I guess do it that way

Alan

