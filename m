Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUI0JEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUI0JEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUI0JEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:04:51 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:11648 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S266467AbUI0JDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:03:42 -0400
Date: Mon, 27 Sep 2004 19:03:43 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, jgarzik@pobox.com, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: strange network slowness in 2.6 unless pingflooding
Message-ID: <20040927090342.GA1794@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is still happening. I ran the same set of tests on a totally
different network, with my xircom  realport ethernet card (tulip
driver - 16bit) and from linux to linux and windows to linux. Scrolling
through a message in mutt eventually slows down and if I lift my finger
off the enter key whilst it's slow the scrolling keeps going, as if it
was all bufferd. If I do a pingflood (ping -f) from a machine to my
laptop it's all fine.

I am also now running 2.6.9-rc1-mm4.

Help? :/

----- Forwarded message from CaT <cat@zip.com.au> -----

Date: 	Thu, 19 Aug 2004 12:03:40 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: Whacky 2.6 network behaviour
Organisation: Furball Inc.
X-Mailing-List: 	linux-kernel@vger.kernel.org

I have an SSH session across a 100mb network from my desktop to my
laptop. It's mostly ok but when I scroll line-by-line on a message
with mutt it can fo really fast for a bit and then slows down to
almost a line per second and keeps going after I take my finger off
the enter key. 

If I pingflood the laptop from the desktop things improve drastically
and I only get a few freezes here and there. If I pingflood with 60000
byte packets things get a little better but then a severe loss of
pings occurs. Each time the pings are lost my SSH connection also
freezes.

If I ping a different host from my desktop (like my gateway) I get no
pingloss with 60000 byte packets (though this doesn't help with the
scrolling issues. :)

If I ping my desktop from my laptop with 60000 byte packets, the freezes
are totally gone and I get no pingloss. If I ping my gateway from my
laptop with 60000 byte packets I also get no pingloss and the freezes
are also gone.

My desktop is using kernel 2.6.7, my laptop 2.6.8.1 and the gw 2.4.27.
Cards in use are: desktop: 3com 3c59x; laptop: e100 (intels); gw:
 e100 (intels). CPUs are: desktop: P3 600; laptop: P3 700; gw: p3 500.

(Hmm. Spoke too soon. There is still SOME packet loss but it's more a
freak thing rather then a repeated occurance - I've only seen it once
for the last two cases and I've been flood pinging for the laptop for
the majority of this message).

I'll be more then happy to do any debugging/diag but I need to know
what is needed and, if need be, how to get it so if any help is requried
please shout and I'll get on it ASAP.

-- 
    Red herrings strewn hither and yon.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

-- 
    Red herrings strewn hither and yon.
