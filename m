Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135452AbRAGD3d>; Sat, 6 Jan 2001 22:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135477AbRAGD3X>; Sat, 6 Jan 2001 22:29:23 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:61444
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S135452AbRAGD3I>; Sat, 6 Jan 2001 22:29:08 -0500
Date: Sun, 7 Jan 2001 16:29:05 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission policy!)
Message-ID: <20010107162905.B1804@metastasis.f00f.org>
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A578F27.D2A9DF52@candelatech.com>; from greearb@candelatech.com on Sat, Jan 06, 2001 at 02:33:27PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 02:33:27PM -0700, Ben Greear wrote:

    I'm hoping that I can get a few comments on this code.  It was
    added to (significantly) speed up things like 'ifconfig -a' when
    running with 4000 or so VLAN devices.  It should also help other
    instances with lots of (virtual) devices, like FrameRelay, ATM,
    and possibly virtual IP interfaces.  It probably won't help
    'normal' users much, and in it's final form, should probably be a
    selectable option in the config process.

Virtual IP interfaces in the form of ifname:<number> (e.g. eth:1) IMO
should be deprecated and removed completely in 2.5.x. It's an ugly
external wart that should be removed.

That said, if this was done -- how would things like routing daemons
and bind cope? Actually, when I think about it they can't cope with
situating like this now:

tapu:~# ip addr show lo
1: lo: <LOOPBACK,UP> mtu 3904 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet 10.0.0.1/32 scope global lo



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
