Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbRAAPkH>; Mon, 1 Jan 2001 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131862AbRAAPj5>; Mon, 1 Jan 2001 10:39:57 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:28433 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S131861AbRAAPjs>;
	Mon, 1 Jan 2001 10:39:48 -0500
Date: Mon, 1 Jan 2001 16:09:18 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101011509.QAA15904@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-prerelease, AX25 problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi and Happy New Year,

I've just compiled and tested 2.4.0-prerelease. My AX25 (hamradio) system does
not work with this new release. There is a timing problem. When a fram is sent
on the air, the frame is VERY long (switched off by the watchdog of my drsi
card) and contains no data. On this point of vue, the previous test version was
right.

My system :
-----------

K6-2 500 / 128Mb
Kernel modules         2.3.24
Gnu C                  2.95.2
Binutils               2.9.5.0.41
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ppp slhc af_packet scc ax25 parport_probe parport_pc lp
parport mousedev usb-ohci hid input autofs lockd sunrpc usbcore serial unix

Ax25 related config :
---------------------
#
# Amateur Radio support
#
CONFIG_HAMRADIO=y
#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set
#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
# CONFIG_BPQETHER is not set
# CONFIG_DMASCC is not set
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=m
# CONFIG_BAYCOM_SER_HDX is not set
# CONFIG_BAYCOM_PAR is not set
# CONFIG_BAYCOM_EPP is not set
# CONFIG_SOUNDMODEM is not set
# CONFIG_YAM is not set


-----

Regards
		
			Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
