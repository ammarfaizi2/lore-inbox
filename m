Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132944AbRDESNl>; Thu, 5 Apr 2001 14:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132959AbRDESNc>; Thu, 5 Apr 2001 14:13:32 -0400
Received: from munch-it.turbolinux.com ([38.170.88.129]:27389 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S132944AbRDESNU>;
	Thu, 5 Apr 2001 14:13:20 -0400
Date: Thu, 5 Apr 2001 11:12:27 -0700
From: Prasanna P Subash <psubash@turbolinux.com>
To: Marcus Meissner <mm@jet.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Problem] 3c90x on 2.4.3-ac3
Message-ID: <20010405111227.A2597@turbolinux.com>
In-Reply-To: <20010404180709.A564@turbolinux.com> <200104050814.f358EuT01869@jet.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104050814.f358EuT01869@jet.caldera.de>; from Marcus Meissner on Thu, Apr 05, 2001 at 10:14:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats right. ACPI was what made 3c90x not work :( With APM it works perfectly.

Thanks Marcus.

On Thu, Apr 05, 2001 at 10:14:56AM +0200, Marcus Meissner wrote:
> In article <20010404180709.A564@turbolinux.com> you wrote:
> 
> > hi lkml,
> > 	I just built 2.4.3-ac3 with my old 2.4.2 .config and somehow networking does not work. 
> > dhclient eventually froze the machine.
> 
> > here is what dhclient complains.
> 
> > [root@psubash linux]# cat /tmp/error.txt
> > skb: pf=2 (unowned) dev=lo len=328
> > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 F=0x0000 T=16
> > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 14
> > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > skb: pf=2 (unowned) dev=lo len=328
> > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 F=0x0000 T=16
> > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 9
> > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 12
> > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > skb: pf=2 (unowned) dev=lo len=328
> 
> > Here is my ver_linux info
> 
> ...
> > CONFIG_ACPI=y
> 
> The ACPI powermanagement for the 3c59x devices appears to be a bit broken.
> 
> Disable ACPI support. Recompile. Reboot. Watch problem disappear hopefully.
> 
> Ciao, Marcus
