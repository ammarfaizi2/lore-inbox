Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136731AbREJPNl>; Thu, 10 May 2001 11:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136735AbREJPNb>; Thu, 10 May 2001 11:13:31 -0400
Received: from popeye.ipv6.univ-nantes.fr ([193.52.101.20]:4 "HELO
	popeye.ipv6.univ-nantes.fr") by vger.kernel.org with SMTP
	id <S136731AbREJPNS>; Thu, 10 May 2001 11:13:18 -0400
Subject: Deadlock/crash with Quad tulip card in 2.4
From: Yann Dupont <Yann.Dupont@IPv6.univ-nantes.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10+cvs.2001.04.18.22.02 (Preview Release)
Date: 10 May 2001 17:13:15 +0200
Message-Id: <989507596.18286.0.camel@olive>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I'm having problem with Quad eth100 tulip (digital 21140) cards.

The machine was acting as a bridge with kernel 2.2 very reliably.

Now, when I boot 2.4.4-ac6, the machine hangs - no oops, nothing. Just
hang.

even CTRL-Scroll lock does nothing.

I supected a bridge problem (I know 2.2  & 2.4 bridge are different) But
it's not the case as I reproduce the bug on another machine (with
another motherboard. kernel 2.4.4-ac6 where the bridge is not
configured.)

single boot is OK,

ifconfig eth0 up is ok (MII negotiation is OK)
ifconfig eth1 up crash the machine -

on another boot i tried this :

ifconfig eth0 up
ifconfig eth0 down

ifconfig eth1 up is OK
ifconfig eth1 down ... etc etc

This works as long as only one interface is up. 

If only 1 interface is up, the machine works reliably.

just putting 2 interfaces up hang the machine.

Can this be an  IRQ sharing / bridge  problem  ??? (all interface shares
the same IRQ and are after a bridge)

I don't know if this is ac-series specific. I'll try tomorrow.

Any Idea how I can test further ? Without oops it's not easy...

Yann Dupont.

-- 
\|/ ____ \|/ Fac. des sciences de Nantes-Linux-Python-IPv6-ATM-BONOM....
"@'/ ,. \@"  Tel :(+33) [0]251125865(AM)[0]251125857(PM)[0]251125868(Fax)
/_| \__/ |_\ Yann.Dupont@sciences.univ-nantes.fr
   \__U_/    http://www.unantes.univ-nantes.fr/~dupont

