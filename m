Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135174AbREAAXX>; Mon, 30 Apr 2001 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbREAAXN>; Mon, 30 Apr 2001 20:23:13 -0400
Received: from juicer24.bigpond.com ([139.134.6.34]:5319 "EHLO
	mailin3.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S129245AbREAAXA>; Mon, 30 Apr 2001 20:23:00 -0400
Date: Tue, 1 May 2001 00:23:14 +1000
From: Brett <brett@macfeegles.com.au>
To: linux-kernel@vger.kernel.org
Subject: CML2 doesn't like my .config
Message-ID: <Pine.LNX.4.21.0105010018440.16099-100000@tae-bo.generica.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Just gave CLM2 (1.3.3) a go with linux-2.4.3-ac14

Results:

ISA=y (deduced from X86)
This configuration violates the following constraints:
'((NET_PCMCIA <= PCMCIA) and (NET_PCMCIA <= NET_ETHERNET))'

erm... OK.
Relevant bits of .config

# egrep CONFIG_PCMCIA\|NET_PCMCIA\|NET_ETHERNET .config
CONFIG_PCMCIA=y
# CONFIG_NET_ETHERNET is not set
CONFIG_NET_PCMCIA=y
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_PCMCIA_IBMTR is not set
# CONFIG_NET_PCMCIA_RADIO is not set
# CONFIG_PCMCIA_SERIAL_CS is not set

Is this really a problem ???
I gather its saying "you have support for a pcmcia network card, but not
for pcmcia" (which i do) ... and "you have support for a pcmcia network
card, but not for ethernet (quite true).

This .config has worked fine for me for countless kernels.  Do i _really_
need to manually put in ethernet support ... I just assumed that didn't
cover pcmcia, as it has its own section in the network device screen.

More .config available on request.

Machine is a Toshiba 100CS lappy.  No PCI bus, and a xircom ceIIps pcmcia
10baseT card.

thanks,

	/ Brett

