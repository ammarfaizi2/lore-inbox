Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbTHTODP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbTHTODP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:03:15 -0400
Received: from h008.c000.snv.cp.net ([209.228.32.72]:57585 "HELO
	c000.snv.cp.net") by vger.kernel.org with SMTP id S261986AbTHTODF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:03:05 -0400
X-Sent: 20 Aug 2003 14:03:01 GMT
Message-ID: <3F438C32.3070705@cs.uiuc.edu>
Date: Wed, 20 Aug 2003 09:56:50 -0500
From: Casey Carter <ccarter@cs.uiuc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [2.4.2X] "Undeletable" ARP entries?
References: <20030820113208.GA11163@merlin.emma.line.org>
In-Reply-To: <20030820113208.GA11163@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>Hi,
>
>I have strange ARP behaviour here, that I can reproduce. Might be a
>kernel bug.
>
>SHORT: I can use the "arp" tool to set an ARP entry that the "arp" tool
>cannot delete and that hides from "ip"'s view. I know a workaround (at
>the very end of the mail).
>
>LONG:
>
>Use either of:
>
>   SuSE 2.4.20 kernel for 8.2 (k_athlon-2.4.20-96)
>or 2.4.22-rc2-ac1
>   (I haven't tried any other version)
>
>Use this tool:
>
>$ arp -V
>net-tools 1.60
>arp 1.88 (2001-04-04)
>+I18N
>AF: (inet) +UNIX +INET +INET6 +IPX +AX25 +NETROM +X25 +ATALK -ECONET -ROSE
>HW: (ether) +ETHER +ARC +SLIP +PPP +TUNNEL +TR +AX25 +NETROM +X25 +FR -ROSE -ASH +SIT +FDDI +HIPPI -HDLC/LAPB 
>
>Now type (192.168.4.4 isn't available, I would like to use it as SNAT
>source):
>
>$ arp -Ds 192.168.4.4 eth1 pub
>
>This entry cannot be deleted:
>
>$ arp -d 192.168.4.4
>SIOCDARP(priv): Network is unreachable
>(even if a route for 192.168.4.4 is set, the entry isn't removed)
>$ arp -d 192.168.4.4 pub
>SIOCDARP(pub): No such file or directory
>
>  
>
Try "arp -i eth1 -d 192.168.4.4 pub"

-- 
Casey Carter
Casey@Carter.net
ccarter@cs.uiuc.edu
AIM: cartec69


