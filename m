Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbTCHU6Z>; Sat, 8 Mar 2003 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCHU6Y>; Sat, 8 Mar 2003 15:58:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51922 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262213AbTCHU6X>;
	Sat, 8 Mar 2003 15:58:23 -0500
Date: Sat, 08 Mar 2003 12:50:24 -0800 (PST)
Message-Id: <20030308.125024.44441125.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] obselete some atm_vcc members
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200303051547.h25FleGi006585@locutus.cmf.nrl.navy.mil>
References: <200303051547.h25FleGi006585@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Wed, 05 Mar 2003 10:47:40 -0500

   it has been suggested that atm_vcc has redundant members with
   struct sock.
   
   this patch removes family, tx_inuse, rx_inuse, and recvq from 
   atm_vcc in favor of sk->family, sk->wmem_alloc, sk->rmem_alloc,
   and sk->receive_queue (respectively).

Applied, but Chas please build fresh patches in the future.

This stuff was all against a tree which still had the atm_dev
semaphore instead of the new spinlock.  Therefore half of the patches
rejected and I had to put these parts in by hand.

I did it this time, but really this needs to be done by you.
:-)
