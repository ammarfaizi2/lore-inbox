Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSBCSpn>; Sun, 3 Feb 2002 13:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSBCSpf>; Sun, 3 Feb 2002 13:45:35 -0500
Received: from clavin.cs.tamu.edu ([128.194.130.106]:26551 "EHLO cs.tamu.edu")
	by vger.kernel.org with ESMTP id <S287532AbSBCSpQ>;
	Sun, 3 Feb 2002 13:45:16 -0500
Date: Sun, 3 Feb 2002 12:45:13 -0600 (CST)
From: Xinwen - Fu <xinwenfu@cs.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: raw socket packet and iptables
Message-ID: <Pine.SOL.4.10.10202031241180.17613-100000@dogbert>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

	I want  to know how a raw packet passes the chain of iptables.

	Here are the iptables chains

--->PRE------>[ROUTE]--->FWD---------->POST------>
        Conntrack    |       Filter   ^    NAT (Src)
        Mangle       |                |    Conntrack
        NAT (Dst)    |             [ROUTE]
        (QDisc)      v                |
                     IN Filter       OUT Conntrack
                     |  Conntrack     ^  Mangle
                     |                |  NAT (Dst)
                     v                |  Filter


	So how a raw packet go through these chains?

	Thanks!!

Xinwen Fu


