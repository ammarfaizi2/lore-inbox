Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbRKINmF>; Fri, 9 Nov 2001 08:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279903AbRKINl6>; Fri, 9 Nov 2001 08:41:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12418 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279798AbRKINlV>;
	Fri, 9 Nov 2001 08:41:21 -0500
Date: Fri, 09 Nov 2001 05:41:10 -0800 (PST)
Message-Id: <20011109.054110.104033787.davem@redhat.com>
To: ak@suse.de
Cc: alan@lxorguk.ukuu.org.uk, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011109143930.C30575@wotan.suse.de>
In-Reply-To: <20011109141755.A30575@wotan.suse.de>
	<20011109.052554.41631501.davem@redhat.com>
	<20011109143930.C30575@wotan.suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Fri, 9 Nov 2001 14:39:30 +0100

   On Fri, Nov 09, 2001 at 05:25:54AM -0800, David S. Miller wrote:
   > Why in the world do we need indirection function call pointers
   > in TCP to handle that?
   
   To handle the case of not having a separate TIME-WAIT table
   (sorry for being unclear). Or alternatively several conditionals. 
   
The TIME-WAIT half of the hash table is most useful on
clients actually.

I mean, just double the amount you "downsize" the TCP established
hash table if it bothers you that much.

Franks a lot,
David S. Miller
davem@redhat.com
