Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSFKHmn>; Tue, 11 Jun 2002 03:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSFKHlb>; Tue, 11 Jun 2002 03:41:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316885AbSFKHkh>;
	Tue, 11 Jun 2002 03:40:37 -0400
Date: Tue, 11 Jun 2002 00:36:25 -0700 (PDT)
Message-Id: <20020611.003625.05877183.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206110938.52090.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Tue, 11 Jun 2002 09:38:52 +0200
   
   You don't have to fully expose it. We make a simple rule like:
   If you want to do DMA to a variable it needs "DMA_ALIGN after the
   name in the declaration". Architectures could define it, with generic nop.
   People will get it wrong by doing DMA to members of structures
   otherwise. There's no really painless way to solve this.
   You have to introduce a new rule anyway.

The DMA_ALIGN attribute doesn't work, on some systems the PCI
cacheline size is determined at boot time not compile time.
