Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTBTHoi>; Thu, 20 Feb 2003 02:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBTHoi>; Thu, 20 Feb 2003 02:44:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54214 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264919AbTBTHoh>;
	Thu, 20 Feb 2003 02:44:37 -0500
Date: Wed, 19 Feb 2003 23:38:55 -0800 (PST)
Message-Id: <20030219.233855.06545451.davem@redhat.com>
To: ak@suse.de
Cc: sim@netnation.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <p73r8a3xub5.fsf@amdsimf.suse.de>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel>
	<p73r8a3xub5.fsf@amdsimf.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: 20 Feb 2003 08:52:46 +0100
   
   That's probably because of the lazy ICMP socket locking used for the
   ICMP socket. When an ICMP is already in process the next ICMP triggered
   from a softirq (e.g. ECHO-REQUEST) is dropped  
   (see net/ipv4/icmp_xmit_lock_bh())

Good spotting Andi.
