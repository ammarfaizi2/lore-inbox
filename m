Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275479AbRIZSxc>; Wed, 26 Sep 2001 14:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275480AbRIZSxW>; Wed, 26 Sep 2001 14:53:22 -0400
Received: from leg-64-133-146-200-RIA.sprinthome.com ([64.133.146.200]:34573
	"EHLO mail.pirk.com") by vger.kernel.org with ESMTP
	id <S275479AbRIZSxM>; Wed, 26 Sep 2001 14:53:12 -0400
Date: Wed, 26 Sep 2001 11:53:37 -0700 (PDT)
From: Steve Pirk <orion@deathcon.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IP aliasing/Virtual IP's in 2.2.19 or 2.4.10
Message-ID: <Pine.LNX.4.21.0109261152370.7017-100000@mail.pirk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This much I have found so far...
In /usr/src/linux-2.2.16/.config :
CONFIG_IP_MASQUERADE=y
CONFIG_IP_MASQUERADE_ICMP=y
CONFIG_IP_MASQUERADE_MOD=y
CONFIG_IP_MASQUERADE_IPAUTOFW=m
CONFIG_IP_MASQUERADE_IPPORTFW=m
CONFIG_IP_MASQUERADE_MFW=m

In /usr/src/linux-2.2.19/.config
no CONFIG_IP_MASQUERADE lines at all....

Would it be save to add them to a 2.2.19 or 2.4.10 .config file?
Is aliasing/masquerading enabled by default in kernel versions
above 2.2.19?

Steve
--
On Tue, 25 Sep 2001, J Sloan wrote:

  JS> Well now that you mention it I'm not sure
  JS> which option it is now - but rest assured
  JS> it works in e.g. the default Red Hat 7.x and
  JS> roswell kernels, and it works on my self
  JS> compiled kernels - I can send you my
  JS> .config if you want - or maybe someone
  JS> else on the list will fill in the blanks -
  JS> 
  JS> cu
  JS> 
  JS> jjs
  JS> 
  JS> Steve Pirk wrote:
  JS> 
  JS> > I remember a while back that there was an option in make menuconfig
  JS> > to enable IP masquerading or IP aliasing - The last version I
  JS> > remember seeing it in was 2.2.16. I am trying to enable virtual
  JS> > addresses on my box (eth0 and eth0:0 eth0:1 etc), and I am
  JS> > getting the following errors:
  JS> > SIOCSIFADDR: No such device
  JS> > SIOCSIFFLAGS: No such device
  JS> > when I issue the command:
  JS> > /sbin/ifconfig eth0:0 64.133.146.201 broadcast 64.133.146.255 \
  JS> > netmask 255.255.255.224
  JS> >
  JS> > In the 2.2.16 menuconfig there was the following option inside of
  JS> > Network Options:
  JS> > [*] IP: masquerading
  JS> > Enabling this allow me to define virtual IP's. I cannot find the
  JS> > same option in 2.2.19, 2.4.4, or in 2.4.10.
  JS> > Does anyone know where/how to enable this much needed fuctionality?
  JS> >
  JS> > Thansk in advance.
  JS> > --
  JS> > Steve Pirk
  JS> > orion@deathcon.com . deathcon.com . pirk.com . webops.com . t2servers.com
  JS> >
  JS> > -
  JS> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
  JS> > the body of a message to majordomo@vger.kernel.org
  JS> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
  JS> > Please read the FAQ at  http://www.tux.org/lkml/
  JS> 

-- 
Steve Pirk
orion@deathcon.com . deathcon.com . pirk.com . webops.com . t2servers.com 


