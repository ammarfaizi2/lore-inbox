Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSAUKWW>; Mon, 21 Jan 2002 05:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280588AbSAUKWM>; Mon, 21 Jan 2002 05:22:12 -0500
Received: from ns.ithnet.com ([217.64.64.10]:37385 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279798AbSAUKWB>;
	Mon, 21 Jan 2002 05:22:01 -0500
Date: Mon, 21 Jan 2002 11:21:55 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] Problem with TX/RX-network-card-counters
Message-Id: <20020121112155.56f71375.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

today I ran into a problem with the TX/RX-counters of my tulip network cards. I
run the box under 2.2.19 with tulip.c:v0.91g-ppc 7/16/99
becker@cesdis.gsfc.nasa.gov, but this may be of common interest. Plain and
simple my TX counter reached 2G and the network connection just broke down. I
don't exactly know why, but this is obviously a bug. There are two solutions
possible for this:

1) wrap around the counter and restart them at zero.
2) enlarge the counter from (possibly) int or 32-bit to at least 64 bit.

I favor 2) very much, because wrap-around has a real m*d*s flair ;-)

Is this network-card specific? Is this fixed in 2.4 or later?

Regards,
Stephan


