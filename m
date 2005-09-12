Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVILK2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVILK2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVILK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:28:24 -0400
Received: from newmail.linux4media.de ([193.201.54.81]:42884 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S1750720AbVILK2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:28:24 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-mm2 hard lockup
Date: Mon, 12 Sep 2005 12:28:23 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121228.25092.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-mm2 locks up hard occasionally (happened for me twice, each time about 
20 minutes after booting).
It left the following in the syslog:

Sep 11 23:19:55 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0) 
failed at net/ipv4/tcp_input.c (2148)                                                
Sep 11 23:19:59 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0) 
failed at net/ipv4/tcp_input.c (2148)                                                
Sep 11 23:25:23 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0) 
failed at net/ipv4/tcp_input.c (2147)                                              
Sep 11 23:26:04 dhcppc0 last message repeated 2 times                           
Sep 11 23:27:55 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0) 
failed at net/ipv4/tcp_input.c (2147)                                              
Sep 11 23:27:57 dhcppc0 kernel: KERNEL: assertion ((int)tp->lost_out >= 0) 
failed at net/ipv4/tcp_input.c (2148)                                                
Sep 11 23:28:00 dhcppc0 kernel: KERNEL: assertion ((int)tp->sacked_out >= 0) 
failed at net/ipv4/tcp_input.c (2147)

(This was compiled without sysrq support, therefore no detailed trace)

LLaP
bero
