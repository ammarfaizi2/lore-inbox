Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSFKGnB>; Tue, 11 Jun 2002 02:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSFKGnA>; Tue, 11 Jun 2002 02:43:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30658 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316860AbSFKGm7>;
	Tue, 11 Jun 2002 02:42:59 -0400
Date: Mon, 10 Jun 2002 23:38:50 -0700 (PDT)
Message-Id: <20020610.233850.60926092.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206110823.52065.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Tue, 11 Jun 2002 08:23:52 +0200
   
   That would mean doing things like memory allocations for one single
   byte. Also it would affect things like the scsi layer (sense buffer in
   the structure).
   And it would be additional overhead for everybody for the benefit
   of a small minority. An alignment macro could be turned into a nop
   on some architectures.

The problem is people are going to get it wrong if we expose all of
this cacheline crap to the drivers.
