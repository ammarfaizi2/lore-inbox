Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144975AbRA2CpU>; Sun, 28 Jan 2001 21:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145006AbRA2CpL>; Sun, 28 Jan 2001 21:45:11 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23561 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S144961AbRA2CpE>;
	Sun, 28 Jan 2001 21:45:04 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101290245.f0T2j2Y438757@saturn.cs.uml.edu>
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
To: vii@altern.org (John Fremlin)
Date: Sun, 28 Jan 2001 21:45:02 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulus@linuxcare.com,
        linux-ppp@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.> from "John Fremlin" at Jan 27, 2001 10:54:51 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin writes:

> When the IP address of an interface changes, TCP connections with the
> old source address are useless. Applications are not notified of this
> and time out ordinarily, just as if nothing had happened. This is
> behaviour isn't very helpful when you have a dynamic IP and know
> you're probably not going to get the old one back. In that case, you
...
> I patched userspace ppp-2.4.0 to use this functionality. It would be
> better if SIOCKILLADDR were not used until we are sure that the new IP
> is in fact different from the old one, but pppd in demand mode would

I get the same IP about 2/3 of the time, so it is pretty important
to avoid killing connections until after the new IP is known.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
