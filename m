Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbUKQUb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbUKQUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUKQUaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:30:39 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:29572 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262447AbUKQU1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:27:34 -0500
Date: Wed, 17 Nov 2004 21:30:33 +0100
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Packet capturing, iptables and eth0 vs. dummy0
Message-ID: <20041117203033.GA7907@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I've noticed that, no matter what filtering is iptables doing,
tcpdump gets all packets from interface eth0 as seen in the bus, but
doesn't do the same in dummy0. I'll explain it further...

    Let's say that I'm filtering all incoming TCP SYN packets on all
interfaces that have a destination port of 6666 (for example), and
I'm listening, with tcpdump, to all packets in eth0. Well, I use
another computer to try to connect to port 6666 of the machine
running tcpdump and the packet filter, and obviously I'm unable to
connect (without the filter I can do it normally), but I see the SYN
packets in the output of tcpdump.

    If I do exactly the same from the machine running tcpdump and the
filter, I cannot connect (without the filter I can), but no output
comes from tcpdump, which is exactly what I expected in the case
explained in the paragraph above.

    Is is normal? Is normal that tcpdump shows packets before they
enter the filter when the interface is a real one (eth0) but no when
you access through a dummy interface or localhost, or am I missing
anything?

    Thanks a lot in advance :)
    
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
