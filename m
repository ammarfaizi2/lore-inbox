Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTANMZ4>; Tue, 14 Jan 2003 07:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTANMZz>; Tue, 14 Jan 2003 07:25:55 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:55010 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262528AbTANMZz>;
	Tue, 14 Jan 2003 07:25:55 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15908.995.730603.520853@harpo.it.uu.se>
Date: Tue, 14 Jan 2003 13:34:43 +0100
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
In-Reply-To: <Pine.LNX.4.44.0301111659230.2174-100000@montezuma.mastecende.com>
References: <200301111605.RAA06360@harpo.it.uu.se>
	<Pine.LNX.4.44.0301111659230.2174-100000@montezuma.mastecende.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > yOn Sat, 11 Jan 2003, Mikael Pettersson wrote:
 > 
 > > Cardbus/hotplugging is still broken in 2.5.56. Inserting a
 > > card fails due a bogus 'resource conflict', and ejecting it
 > > oopses the kernel. It's been this way since 2.5.4x-something.
 > > 
 > > Dell Latitude, Texas PCI1131 cardbus bridge, 3c575_cb NIC.
 > 
 > I think its a matter of resource collisions only and the oops is 
 > inadequate cleanup on failure. I've tested cardbus/hotplugging on a TI PCI1211 and 
 > Tulip 21142 based NIC. Perhaps find the last working kernel?

I did some tests yesterday, and 2.5.49 was the last kernel to work at all:
boot, insert NIC, and it goes up. But the last few 2.5.4x all seemed to
handle ejection incorrectly: ejecting and reinserting the NIC did _not_
successfully enable it, and manually down/up eth0 didn't help.

/Mikael
