Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSHGCvD>; Tue, 6 Aug 2002 22:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSHGCvD>; Tue, 6 Aug 2002 22:51:03 -0400
Received: from pcp01179415pcs.strl1201.mi.comcast.net ([68.60.208.36]:9206
	"EHLO mythical") by vger.kernel.org with ESMTP id <S316683AbSHGCvD>;
	Tue, 6 Aug 2002 22:51:03 -0400
Date: Tue, 6 Aug 2002 22:54:10 -0400
From: Ryan Anderson <ryan@michonline.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
Subject: Re: ethtool documentation
Message-ID: <20020807025410.GG24032@mythical.michonline.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
	abraham@2d3d.co.za
References: <Pine.LNX.4.33L2.0208060834030.10089-100000@dragon.pdx.osdl.net> <Pine.LNX.3.95.1020806151104.25149A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020806151104.25149A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The EEPROM (SEEPROM) on these NICS is used to contain the startup
> configuration bits and the IEEE Station Address. This must be a
> unique number that is assigned so that there is no other such
> number in (preferably) the world, and certainly in the LAN.
> If you let a user write to this area, you will allow the user
> to destroy the connectivity on a LAN.
> 
> If you provide an ioctl() to write new SEEPROM contents, it had
> better be disabled in code that user's (any, including root)
> can execute because, if caught, your company may lose it's IEEE
> Station Addresses and never again be allowed to configure Ethernet
> Controllers.

I think you overstate the seriousness here - it's not unheard of for
manufacturers to ship hardware with duplicate MAC addresses - a trivial
search on Google turns up Cisco as one offender:

http://www.cisco.com/warp/public/770/7.html

> 
> Because of this, there is no such thing as 'unused eeprom space' in
> the Ethernet Controllers. Be careful about putting this weapon in
> the hands of the 'public'. All you need is for one Linux Machine
> on a LAN to end up with the same IEEE Station Address as another
> on that LAN and connectivity to everything on that segment will
> stop. You do this once at an important site and Linux will get a
> very black eye.

Worse than GE?

http://www.gefanuc.com/support/plc/m030202.htm

Being able to permanently fix a screwed up card that duplicated another
card on my LAN would be nice, imo.

Of course, this assumes that IEEE Station Address == MAC address.


--
Ryan Anderson
  sometimes Pug Majere
