Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRDEIQT>; Thu, 5 Apr 2001 04:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDEIQJ>; Thu, 5 Apr 2001 04:16:09 -0400
Received: from jet.caldera.de ([212.34.180.34]:21764 "EHLO jet.caldera.de")
	by vger.kernel.org with ESMTP id <S132572AbRDEIP4>;
	Thu, 5 Apr 2001 04:15:56 -0400
Date: Thu, 5 Apr 2001 10:14:56 +0200
Message-Id: <200104050814.f358EuT01869@jet.caldera.de>
From: Marcus Meissner <mm@jet.caldera.de>
To: psubash@turbolinux.com (Prasanna P Subash), linux-kernel@vger.kernel.org
Subject: Re: [Problem] 3c90x on 2.4.3-ac3
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010404180709.A564@turbolinux.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010404180709.A564@turbolinux.com> you wrote:

> hi lkml,
> 	I just built 2.4.3-ac3 with my old 2.4.2 .config and somehow networking does not work. 
> dhclient eventually froze the machine.

> here is what dhclient complains.

> [root@psubash linux]# cat /tmp/error.txt
> skb: pf=2 (unowned) dev=lo len=328
> PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 F=0x0000 T=16
> DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 14
> ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> skb: pf=2 (unowned) dev=lo len=328
> PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 F=0x0000 T=16
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 9
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 12
> ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> skb: pf=2 (unowned) dev=lo len=328

> Here is my ver_linux info

...
> CONFIG_ACPI=y

The ACPI powermanagement for the 3c59x devices appears to be a bit broken.

Disable ACPI support. Recompile. Reboot. Watch problem disappear hopefully.

Ciao, Marcus
