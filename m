Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130368AbQLBURH>; Sat, 2 Dec 2000 15:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130369AbQLBUQ5>; Sat, 2 Dec 2000 15:16:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36617 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130368AbQLBUQo>;
	Sat, 2 Dec 2000 15:16:44 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012021946.TAA07734@raistlin.arm.linux.org.uk>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
To: jgarzik@mandrakesoft.mandrakesoft.com (Jeff Garzik)
Date: Sat, 2 Dec 2000 19:46:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Dec 02, 2000 01:07:29 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Does 'ifconfig eth0 media xxx' wind up calling dev->set_config?

Yes.  See drivers/acorn/net/etherh.c for an(other) example driver
supporting 10baseT and 10base2.

> If yes, my guess is correct, I think the proper solution is to:
> * create a generic set_config, which does nothing but convert the calls'
> semantics into ethtool semantics, and
> * add ethtool support to the specific driver

Sounds logical.
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
