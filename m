Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRJYNax>; Thu, 25 Oct 2001 09:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJYNad>; Thu, 25 Oct 2001 09:30:33 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:51076 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273333AbRJYNa3>;
	Thu, 25 Oct 2001 09:30:29 -0400
Date: Thu, 25 Oct 2001 15:31:03 +0200
From: Ookhoi <ookhoi@ookhoi.xs4all.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Thomas Svedberg <thsv@bigfoot.com>, linux-kernel@vger.kernel.org,
        rgooch@atnf.csiro.au
Subject: Re: Network device problems
Message-ID: <20011025153103.T24475@humilis>
Reply-To: ookhoi@ookhoi.xs4all.nl
In-Reply-To: <1004013479.2597.50.camel@athlon1.hemma.se> <3BD80A32.16D618FD@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD80A32.16D618FD@mandrakesoft.com>
User-Agent: Mutt/1.3.19i
X-Uptime: 10:37:19 up 9 days, 16:44, 10 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

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

But what about:

CONFIG_NETLINK_DEV
  This option will be removed soon. Any programs that want to use
  character special nodes like /dev/tap0 or /dev/route (all with major
  number 36) need this option, and need to be rewritten soon to use
  the real netlink socket.
  This is a backward compatibility option, choose Y for now.

IIRC it says "will be removed soon" and "This is a backward
compatibility option" for a long time now (since 2.3?, didn' check). It
is not strange for people not to enable it imho. 

	Ookhoi
