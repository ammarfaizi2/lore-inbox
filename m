Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRJYSLK>; Thu, 25 Oct 2001 14:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJYSKu>; Thu, 25 Oct 2001 14:10:50 -0400
Received: from mailc.telia.com ([194.22.190.4]:45814 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S275822AbRJYSKr> convert rfc822-to-8bit;
	Thu, 25 Oct 2001 14:10:47 -0400
Subject: Re: Network device problems
From: Thomas Svedberg <thsv@bigfoot.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
In-Reply-To: <3BD80A32.16D618FD@mandrakesoft.com>
In-Reply-To: <1004013479.2597.50.camel@athlon1.hemma.se> 
	<3BD80A32.16D618FD@mandrakesoft.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16 (Preview Release)
Date: 25 Oct 2001 20:11:06 +0200
Message-Id: <1004033467.1726.3.camel@athlon1.hemma.se>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick note to anyone else having this problem:
Only enabling CONFIG_NETLINK_DEV was not enough for me, also enabling
CONFIG_RTNETLINK did it for me. I now have:

CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y

tor 2001-10-25 klockan 14.48 skrev Jeff Garzik:
> Thomas Svedberg wrote:
> > 
> > Just updated to RedHat 7.2 and after compiling and starting my new
> > kernel my network interfaces won't go up (not even lo), I get the
> > following message:
> > "ifup: Cannot send dump request: Connection refused".
> > 
> > Tried kernels 2.4.12-ac2 and -ac6 (One of my -ac2 kernels worked fine
> > before the upgrade).
> > 
> > Using the RedHat precompiled kernels it works (but then I have no lVM)
> > 
> > Anyone have any clues ?
> 
> Yep.  Newer initscripts from RedHat and Mandrake (and others?) require
> CONFIG_NETLINK_DEV.  initscripts runs, IIRC, iproute, which in turn
> requires the netlink device.
> 
> I have a feeling this is going to be a FAQ.  Pretty much anybody who
> uses these initscripts and compiles their own kernel !CONFIG_NETLINK_DEV
> will hit this.


/ Thomas
.......................................................................
 Thomas Svedberg
 Department of Mathematics
 Chalmers University of Technology

 Address: S-412 96 Göteborg, SWEDEN
 E-mail : thsv@bigfoot.com, thsv@math.chalmers.se
 Phone  : +46 31 772 5368
 Fax    : +46 31 772 3595
.......................................................................

