Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNUI7>; Thu, 14 Dec 2000 15:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbQLNUIt>; Thu, 14 Dec 2000 15:08:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132854AbQLNUIb>;
	Thu, 14 Dec 2000 15:08:31 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012141937.TAA02604@raistlin.arm.linux.org.uk>
Subject: Re: linux ipv6 questions.  bugs?
To: kuznet@ms2.inr.ac.ru
Date: Thu, 14 Dec 2000 19:37:37 +0000 (GMT)
Cc: pete@research.NETsol.COM, linux-kernel@vger.kernel.org
In-Reply-To: <200012141931.WAA03039@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Dec 14, 2000 10:31:58 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru writes:
> > bash-2.04# ping6 fe80::a00:2bff:fe95:1d7b
> > connect: Invalid argument
> 
> Yes, of course. Link local address without interface is invalid.

Ok...

bash-2.04# strace ping6 -I fe80::800:2b95:1d7b fe80::800:2b95:1d7b
...
socket(PF_INET6, SOCK_RAW, 58)          = 3
getuid()                                = 0
setuid(0)                               = 0
bind(3, {sin_family=AF_INET6, sin6_port=htons(0), inet_pton(AF_INET6, "fe80::800:2b95:1d7b", &sin6_addr), sin6_flowinfo=htonl(0)}}, 24) = -1 EINVAL (Invalid argument)
write(2, "ping: bind icmp socket: Invalid "..., 41ping: bind icmp socket: Invalid argument) = 41
_exit(1)                                = ?
bash-2.04#

still no go.
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
