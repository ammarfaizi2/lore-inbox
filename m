Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbTCVCW6>; Fri, 21 Mar 2003 21:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbTCVCW6>; Fri, 21 Mar 2003 21:22:58 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:1409 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262656AbTCVCW5>;
	Fri, 21 Mar 2003 21:22:57 -0500
Date: Sat, 22 Mar 2003 03:33:51 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030322023351.GB2050@vana.vc.cvut.cz>
References: <1048295082521@kroah.com> <1048295084971@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048295084971@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 05:04:00PM -0800, Greg KH wrote:
> ChangeSet 1.1189, 2003/03/21 12:45:28-08:00, greg@kroah.com
> 
> i2c: remove i2c_adapter->name and use dev->name instead.
> 
> 
>  drivers/i2c/busses/i2c-ali15x3.c |    8 ++--
>  drivers/i2c/busses/i2c-amd756.c  |    6 ++-
>  drivers/i2c/busses/i2c-amd8111.c |    4 +-
>  drivers/i2c/busses/i2c-i801.c    |    8 ++--
>  drivers/i2c/busses/i2c-isa.c     |    4 +-
>  drivers/i2c/busses/i2c-piix4.c   |    8 ++--
>  drivers/i2c/i2c-algo-bit.c       |   13 +++---
>  drivers/i2c/i2c-algo-pcf.c       |   19 ++++------
>  drivers/i2c/i2c-core.c           |   73 ++++++++++++++++-----------------------
>  drivers/i2c/i2c-dev.c            |   17 +++------
>  drivers/i2c/i2c-elektor.c        |   10 +++--
>  drivers/i2c/i2c-elv.c            |    4 +-
>  drivers/i2c/i2c-philips-par.c    |    4 +-
>  drivers/i2c/i2c-velleman.c       |    4 +-
>  drivers/i2c/scx200_acb.c         |   28 ++++++--------
>  include/linux/i2c.h              |    1 
>  16 files changed, 105 insertions(+), 106 deletions(-)

Although you'll not break matroxfb more than it is currently, can you
also update drivers/video/matrox/{i2c-matroxfb,matroxfb_maven}.* in 
your updates? Or I'll send you patch after this change hits Linus kernel... 

Only problem is that there are apps which search DDC channel by 
looking for i2c bus named "DDC:fbX #Y on i2c-matroxfb", and this 
looks too long for generic driver infrastructure. But "DDC:fbX #Y"
looks acceptable...
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
