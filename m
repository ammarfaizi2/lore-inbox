Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbQKVAbd>; Tue, 21 Nov 2000 19:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQKVAbX>; Tue, 21 Nov 2000 19:31:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:40455 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129309AbQKVAbK>; Tue, 21 Nov 2000 19:31:10 -0500
Message-ID: <3A1B0BCF.71731541@timpanogas.org>
Date: Tue, 21 Nov 2000 16:57:03 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.2.18-22 with non-existent TCPIP route
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

I have an Oops with 2.2.18-22 that only shows up on a Linux server
that's configured as a pppd dial in server with dynamic address
assignment (no DHCP).  Host IP addresses are configured in an
options.ttyS0(192.168.0.1) and options.ttyS1(192.168.0.2) files in
/etc/ppp.  

We caused the Oops by accident when we misconfigured our Cisco CPA 2501
router with a static route for network 207.225.212.40 (mask
255.255.255.248) that pointed to this server (the server had no routes
to this network but used to).  We were moving some servers around to
segregate the law firm onto a private network.

I was not running ksymoops but have it setup now and we are attempting
to recreate the conditions that produced the oops.  The Oops reported is
crashed in process slocate (clearly misleading -- looks like an Oops
from an interrupt).   We will attempt to get the Oops again.  

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
