Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCPHIP>; Fri, 16 Mar 2001 02:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCPHIF>; Fri, 16 Mar 2001 02:08:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:17802 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130380AbRCPHHz>;
	Fri, 16 Mar 2001 02:07:55 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15025.48022.36756.352238@pizda.ninka.net>
Date: Thu, 15 Mar 2001 23:07:02 -0800 (PST)
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler writes:
 > ---------------------------------------------------------
 > [UNKNOWN]  I'm not sure about this: "csum_partial_*" calls the generic
 > 	   cksum routine which does guard against user pointers ---
 > 	   is this redundant paranoia in this case?
 > 
 > /u2/engler/mc/oses/linux/2.4.1/net/ipv4/tcp_output.c:643:tcp_retrans_try_collapse: ERROR:PARAM:651:643: tainted var 'skb_put' (from line 651) used as arg 0 to '__constant_memcpy'

csum_partial_copy_nocheck works on kernel pointers.

Later,
David S. Miller
davem@redhat.com
