Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTH0WRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTH0WRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:17:54 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43169 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262420AbTH0WRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:17:51 -0400
Subject: Re: binary kernel drivers re. hpt370 and redhat
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: joe briggs <jbriggs@briggsmedia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030827145755.7e1ce956.shemminger@osdl.org>
References: <200308271840.30368.jbriggs@briggsmedia.com>
	 <20030827145755.7e1ce956.shemminger@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062022619.23531.38.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 27 Aug 2003 23:17:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-27 at 22:57, Stephen Hemminger wrote:
> On Wed, 27 Aug 2003 18:40:30 -0400
> joe briggs <jbriggs@briggsmedia.com> wrote:
> 
> > I have a client who has a raid controller currently supported under windows, 
> > and now wants to support linux as a bootable device.  Currently, some of 
> > their trade secrets are contained in the driver as opposed to the controller

Standard practice - its not IMHO so much trade secrets as "improving the
barrier to vendor change" 8). Pretty much all of the older PATA
controllers don't actually do hardware raid but bios/driver raid - ie
its the equivalent (or roughly so) of the md layer but locks you into
the vendor. The notable exception here is the 3ware card (there are a 
couple of others too - Promise Supertrak100, SX6000)

We know some of these formats (eg see the hptraid driver in 2.4.2x)

> The problem is more in the bootloader (LILO or GRUB) would not no how
> to do raid. The /boot partition would have to be on a non-raid partition.
> Same problem if driver is statically linked in the kernel.

Plus little issues like the GPL 8)


