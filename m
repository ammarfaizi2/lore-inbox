Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbUKQXZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbUKQXZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUKQXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:14:58 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:64921 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262675AbUKQXO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:14:29 -0500
Date: Thu, 18 Nov 2004 00:17:23 +0100
From: DervishD <lkml@dervishd.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Packet capturing, iptables and eth0 vs. dummy0
Message-ID: <20041117231723.GB7955@DervishD>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20041117203033.GA7907@DervishD> <20041117213843.GV31538@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041117213843.GV31538@sunbeam.de.gnumonks.org>
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

    Hi Harald :)

 * Harald Welte <laforge@gnumonks.org> dixit:
> On Wed, Nov 17, 2004 at 09:30:33PM +0100, DervishD wrote:
> please send netfilter/iptables related questions to the respective
> lists:
> 	netfilter@lists.netfilter.org (for user questions)
> 	netfilter-devel@lists.netfilter.org (for development issues)

    This time the iptables issue was just... collateral, so to say.
The problem was with tcpdump since I knew that packets were being
filtered.
 
> >     I've noticed that, no matter what filtering is iptables doing,
> > tcpdump gets all packets from interface eth0 as seen in the bus, 
> This is correct.  iptables is a IPv4 packet filter.  It is part of the
> IPv4 stack.  tcpdump uses PF_PACKET which attaches right above the
> NIC driver, therefore you capture packets way before they enter the IPv4
> stack.

    OK, I didn't see the problem from that perspective. Anyway, using
'lo' instead of 'dummy' solved the problem :)

    Thanks for the help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
