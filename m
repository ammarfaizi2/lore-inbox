Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132969AbRDESnI>; Thu, 5 Apr 2001 14:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDESm6>; Thu, 5 Apr 2001 14:42:58 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:26842 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132969AbRDESmn>; Thu, 5 Apr 2001 14:42:43 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE80E@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Prasanna P Subash'" <psubash@turbolinux.com>,
        Marcus Meissner <mm@jet.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Problem] 3c90x on 2.4.3-ac3
Date: Thu, 5 Apr 2001 11:40:36 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused. 3c59x.c has a little acpi WOL stuff, but that's it.

What specifically is ACPI doing to break things? Are ACPI and the NIC
sharing any resources?

Regards -- Andy

> -----Original Message-----
> From: Prasanna P Subash [mailto:psubash@turbolinux.com]
> Sent: Thursday, April 05, 2001 11:12 AM
> To: Marcus Meissner
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [Problem] 3c90x on 2.4.3-ac3
> Importance: High
> 
> 
> Thats right. ACPI was what made 3c90x not work :( With APM it 
> works perfectly.
> 
> Thanks Marcus.
> 
> On Thu, Apr 05, 2001 at 10:14:56AM +0200, Marcus Meissner wrote:
> > In article <20010404180709.A564@turbolinux.com> you wrote:
> > 
> > > hi lkml,
> > > 	I just built 2.4.3-ac3 with my old 2.4.2 .config and 
> somehow networking does not work. 
> > > dhclient eventually froze the machine.
> > 
> > > here is what dhclient complains.
> > 
> > > [root@psubash linux]# cat /tmp/error.txt
> > > skb: pf=2 (unowned) dev=lo len=328
> > > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 
> F=0x0000 T=16
> > > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 14
> > > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > > skb: pf=2 (unowned) dev=lo len=328
> > > PROTO=17 0.0.0.0:68 255.255.255.255:67 L=328 S=0x10 I=0 
> F=0x0000 T=16
> > > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 9
> > > DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> > > DHCPDISCOVER on lo to 255.255.255.255 port 67 interval 12
> > > ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
> > > skb: pf=2 (unowned) dev=lo len=328
> > 
> > > Here is my ver_linux info
> > 
> > ...
> > > CONFIG_ACPI=y
> > 
> > The ACPI powermanagement for the 3c59x devices appears to 
> be a bit broken.
> > 
> > Disable ACPI support. Recompile. Reboot. Watch problem 
> disappear hopefully.
> > 
> > Ciao, Marcus
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
