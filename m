Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAMjY>; Fri, 1 Dec 2000 07:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLAMjP>; Fri, 1 Dec 2000 07:39:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129257AbQLAMjJ>;
	Fri, 1 Dec 2000 07:39:09 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012011207.eB1C78523251@flint.arm.linux.org.uk>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
To: cw@f00f.org (Chris Wedgwood)
Date: Fri, 1 Dec 2000 12:07:08 +0000 (GMT)
Cc: romieu@ensta.fr, lists@cyclades.com (Ivan Passos),
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20001201233227.A9457@metastasis.f00f.org> from "Chris Wedgwood" at Dec 01, 2000 11:32:27 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood writes:
> Actually; Ethernet badly needs something like this too. I would kill
> to be able to do something like:
> 
> 	ifconfig eth0 speed 100 duplex full
> 
> o across different networks cards -- I've been thinking about it of
> late as I had to battle with this earlier this week; depending on
> what network card you use, you need different magic incarnations to
> do the above.
> 
> A standard interface is really needed; unless anyone objects I may
> look at drafting something up -- but it will require some input if it
> is not to look completely Ethernet centric.

We already have a standard interface for this, but many drivers do not
support it.  Its called "ifconfig eth0 media xxx":

bash-2.04# ifconfig --help
Usage:
  ifconfig [-a] [-i] [-v] [-s] <interface> [[<AF>] <address>]
...
  [mem_start <NN>]  [io_addr <NN>]  [irq <NN>]  [media <type>]
...
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
