Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTEEQYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTEEQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35263 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263650AbTEEQXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:23:22 -0400
Date: Mon, 05 May 2003 09:35:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 660] New: compile failure in net/decnet/dn_route.c
Message-ID: <10210000.1052152520@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=660

           Summary: compile failure in net/decnet/dn_route.c
    Kernel Version: 2.5.68-bk11
            Status: NEW
          Severity: low
             Owner: jgarzik@pobox.com
         Submitter: john@larvalstage.com


Distribution:  Gentoo 1.4rc4
Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
Problem Description:

  gcc -Wp,-MD,net/decnet/.dn_route.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DKBUILD_BASENAME=dn_route
-DKBUILD_MODNAME=decnet -c -o net/decnet/.tmp_dn_route.o
net/decnet/dn_route.c net/decnet/dn_route.c: In function
`dn_route_output_slow':
net/decnet/dn_route.c:1058: `flp' undeclared (first use in this function)
net/decnet/dn_route.c:1058: (Each undeclared identifier is reported only
once net/decnet/dn_route.c:1058: for each function it appears in.)
net/decnet/dn_route.c: In function `dn_route_input_slow':
net/decnet/dn_route.c:1183: structure has no member named `fwmark'
make[2]: *** [net/decnet/dn_route.o] Error 1
make[1]: *** [net/decnet] Error 2
make: *** [net] Error 2


Steps to reproduce:

Networking support  --->
Networking options  --->
[*]   DECnet: router support (EXPERIMENTAL)

CONFIG_DECNET_ROUTER=y


