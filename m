Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135754AbRAGFMZ>; Sun, 7 Jan 2001 00:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135768AbRAGFMP>; Sun, 7 Jan 2001 00:12:15 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:12296 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135754AbRAGFMD>;
	Sun, 7 Jan 2001 00:12:03 -0500
Message-ID: <3A58097C.5BB52B5@candelatech.com>
Date: Sat, 06 Jan 2001 23:15:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission 
 policy!)
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com> <20010107162905.B1804@metastasis.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Sat, Jan 06, 2001 at 02:33:27PM -0700, Ben Greear wrote:
> 
>     I'm hoping that I can get a few comments on this code.  It was
>     added to (significantly) speed up things like 'ifconfig -a' when
>     running with 4000 or so VLAN devices.  It should also help other
>     instances with lots of (virtual) devices, like FrameRelay, ATM,
>     and possibly virtual IP interfaces.  It probably won't help
>     'normal' users much, and in it's final form, should probably be a
>     selectable option in the config process.
> 
> Virtual IP interfaces in the form of ifname:<number> (e.g. eth:1) IMO
> should be deprecated and removed completely in 2.5.x. It's an ugly
> external wart that should be removed.

I don't know enough to have any serious opinion about virtual IP
interfaces, but I am very certain that VLANs should appear as
an interface to external code/user-land, just as eth0 does.

This hashing helps with VLANs, and since I aim to get VLANs into
the kernel proper sooner or later, having this piece in there
makes my patch a little smaller :)

However, if folks look at the patch and hate it, then it can
be left out, or changed appropriately.

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
