Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268223AbTBWKFx>; Sun, 23 Feb 2003 05:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268236AbTBWKEl>; Sun, 23 Feb 2003 05:04:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60637 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268223AbTBWKEc>;
	Sun, 23 Feb 2003 05:04:32 -0500
Date: Sun, 23 Feb 2003 01:58:19 -0800 (PST)
Message-Id: <20030223.015819.94389615.davem@redhat.com>
To: hch@infradead.org
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030223100234.B15347@infradead.org>
References: <20030221104541.GA18417@wotan.suse.de>
	<20030223.011217.04700323.davem@redhat.com>
	<20030223100234.B15347@infradead.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@infradead.org>
   Date: Sun, 23 Feb 2003 10:02:34 +0000

   > +	icmp_xmit_lock();
   
   Hmm, and I guess the code would be much more readable if you used
   the spin_lock call directly.  The impliclit icmp_socket doesn't
   really help readability either.
   
Sure it does, it encapsulates the icmp_socket->sk->foo->far->fum
dereferencing into one place instead of 4.
