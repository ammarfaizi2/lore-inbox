Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSFURZ1>; Fri, 21 Jun 2002 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSFURZ0>; Fri, 21 Jun 2002 13:25:26 -0400
Received: from bs1.dnx.de ([213.252.143.130]:472 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S316682AbSFURZZ>;
	Fri, 21 Jun 2002 13:25:25 -0400
Date: Fri, 21 Jun 2002 19:25:08 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Subject: ipconfig problems
Message-ID: <20020621192508.I5705@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

[I asked this recently on the linux-net list, but nobody answered. Perhaps
I have more luck here.]

is somebody on this list maintaining the ipconfig (bootp/dhcp) stuff? In
Documentation/nfsroot.txt should be a hint that for the "autoconf"
parameter of "ip=" there is also the possibility to use "dhcp". The
documentation differs from the sourcecode in net/ipv4/ipconfig.c here. 

Reading the docs I thought that if you want to use DHCP you also have to
set "ip=bootp", but this goes terribly wrong. I have the impression that
there can be inconsistencies between the compile time- and runtime
configuration. For example, if you only enable dhcp in the kernel
configuration and put "ip=bootp" on the command line the
ip_auto_config_setup function seems to try to interpret the string as an IP
address, which results in ic_myaddr being set to something else than
INADDR_NONE. Afterwards in ic_bootp_recv this is recognized and the
received (correct) DHCPOFFER is silently droped, which is a pain in the ass
to debug ... :-)

Cheers,
Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

