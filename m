Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVDGRda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVDGRda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVDGRda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:33:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:47858 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262515AbVDGRd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:33:26 -0400
Message-ID: <42556ED5.9080709@onlinehome.de>
Date: Thu, 07 Apr 2005 19:33:09 +0200
From: Florian Attenberger <valdyn@onlinehome.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nico Schottelius <nico-kernel@schottelius.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PMTU, MSS and "fragmentation needed" problem with linux?
References: <20050407122217.GE5211@schottelius.org>
In-Reply-To: <20050407122217.GE5211@schottelius.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cfacada57bf87acb45866c3c4e154171
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from my shorewall.conf.
-----------------
#
# MSS CLAMPING
#
# Set this variable to "Yes" or "yes" if you want the TCP "Clamp MSS to 
PMTU"
# option. This option is most commonly required when your internet
# interface is some variant of PPP (PPTP or PPPoE). Your kernel must
# have CONFIG_IP_NF_TARGET_TCPMSS set.
#
# [From the kernel help:
#
#    This option adds a `TCPMSS' target, which allows you to alter the
#    MSS value of TCP SYN packets, to control the maximum size for that
#    connection (usually limiting it to your outgoing interface's MTU
#    minus 40).
#
#    This is used to overcome criminally braindead ISPs or servers which
#    block ICMP Fragmentation Needed packets.  The symptoms of this
#    problem are that everything works fine from your Linux
#    firewall/router, but machines behind it can never exchange large
#    packets:
#        1) Web browsers connect, then hang with no data received.
#    2) Small mail works fine, but large emails hang.
#    3) ssh works fine, but scp hangs after initial handshaking.
# ]
#
# If left blank, or set to "No" or "no", the option is not enabled.
#
CLAMPMSS=1412
--------------------

see also:
http://en.tldp.org/HOWTO/IP-Masquerade-HOWTO/mtu-issues.html
