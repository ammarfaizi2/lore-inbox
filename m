Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbTEGPPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbTEGPPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:15:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264008AbTEGPO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:14:58 -0400
Date: Wed, 7 May 2003 08:24:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-Id: <20030507082416.0996c3df.rddunlap@osdl.org>
In-Reply-To: <20030507141458.B30005@flint.arm.linux.org.uk>
References: <20030507141458.B30005@flint.arm.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 14:14:58 +0100 Russell King <rmk@arm.linux.org.uk> wrote:

| Does anyone know if there's a reason that the ethernet driver initialisation
| order has changed again in 2.5?
| 
| In 2.2.xx, we had eth0 = NE2000, eth1 = Tulip
| In 2.4, we have eth0 = Tulip, eth1 = NE2000
| And in 2.5, it's back to eth0 = NE2000, eth1 = Tulip
| 
| Both interfaces are on the same bus:
| 
| 00:0a.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
| 00:0d.0 Ethernet controller: Winbond Electronics Corp W89C940F
| 
| Its rather annoying when your dhcpd starts on the wrong interface.

What version of 2.5?

There was a patch 17 days ago by Chuck Ebbert (merged by akpm) that
"fixed" PCI scan order in 2.5 to be same as 2.4.  Comment in changelog
says "Russell King has acked this change."

http://linus.bkbits.net:8080/linux-2.5/cset@1.1042.19.12?nav=index.html|ChangeSet@-3w

An alternative is to use 'nameif' to associate MAC addresses with
interface names.  See here for mini HOWTO:

  http://www.xenotime.net/linux/doc/network-interface-names.txt

--
~Randy
