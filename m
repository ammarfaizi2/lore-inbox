Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTEIMa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbTEIMa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:30:28 -0400
Received: from ns.tasking.nl ([195.193.207.2]:18440 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S262578AbTEIMa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:30:27 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
References: <1052437088.13561.36.camel@orca.madrabbit.org>
From: spam@altium.nl (Dick Streefland)
Subject: Re: The magical mystical changing ethernet interface order
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <5ac2.3ebba1fb.84d7e@altium.nl>
Date: Fri, 09 May 2003 12:41:31 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Lee <ray-lk@madrabbit.org> wrote:
| Debian already supports this, integrated into the normal scheme for
| dealing with interfaces. Anyone running Debian can take a look at
| /usr/share/doc/ifupdown/examples directory, the network-interfaces.gz
| file contains sample /etc/network/interfaces stanzas for configuring
| your interfaces via MAC address:
| 
| 	auto eth0 eth1
| 	mapping eth0 eth1
| 		script /path/to/get-mac-addr.sh
| 		map 11:22:33:44:55:66 lan
| 		map AA:BB:CC:DD:EE:FF internet
| 	iface lan inet static
| 		address 192.168.42.1
| 		netmask 255.255.255.0
| 		pre-up /usr/local/sbin/enable-masq $IFACE
| 	iface internet inet dhcp
| 		pre-up /usr/local/sbin/firewall $IFACE

I just do:

	auto  net
	iface net inet static
		pre-up    nameif net 00:00:C0:4F:8B:F6  
		...

	auto  lan
	iface lan inet static
		pre-up    nameif lan 00:60:B0:EC:92:F9  
		...

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

