Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSJLLm2>; Sat, 12 Oct 2002 07:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJLLm2>; Sat, 12 Oct 2002 07:42:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62084 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262905AbSJLLm2>;
	Sat, 12 Oct 2002 07:42:28 -0400
Date: Sat, 12 Oct 2002 04:41:37 -0700 (PDT)
Message-Id: <20021012.044137.42774593.davem@redhat.com>
To: ahu@ds9a.nl
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021012111759.GA10104@outpost.ds9a.nl>
References: <20021012.114330.78212112.yoshfuji@linux-ipv6.org>
	<20021011.194108.102576152.davem@redhat.com>
	<20021012111759.GA10104@outpost.ds9a.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: bert hubert <ahu@ds9a.nl>
   Date: Sat, 12 Oct 2002 13:17:59 +0200

   On Fri, Oct 11, 2002 at 07:41:08PM -0700, David S. Miller wrote:
   > We believe that the whole SPD/SAD mechanism should move
   > eventually to a top-level flow cache shared by ipv4 and
   > ipv6.
   
   Is this the proposed stacked route system?

Yes, for output mostly.

Also the idea Alexey and I have to move towards a small
efficient flow cache shared by IPv4/IPv6 plays into this
as well.  There are changesets on their way to Linus tonight
which moves ipv4 over to using ipv6's "struct flowi" from
include/net/flow.h as the routing lookup key.

The initial ipsec is intended to be simple, singly linked
lists for the spd/sad databases etc.  Making the feature
freeze is pretty important right now, full blown flow cache
is just performance improvement :)
