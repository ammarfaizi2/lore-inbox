Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSFQWsM>; Mon, 17 Jun 2002 18:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317135AbSFQWsL>; Mon, 17 Jun 2002 18:48:11 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:44279 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317114AbSFQWsK>; Mon, 17 Jun 2002 18:48:10 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15630.26410.326853.534555@wombat.chubb.wattle.id.au>
Date: Tue, 18 Jun 2002 08:48:10 +1000
To: linux-kernel@vger.kernel.org
Subject: lseek on block device
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   Is lseek64(fd, (off64_t)0, SEEK_END) guaranteed to return the
number-of-bytes in a block device (bugs aside)?  Single-UNIX-spec says
yes.  So why do we need BLKGETSIZE64 ??  And why do so many of the
mkfs-like tools try to do a binary search to find the file size?


--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
