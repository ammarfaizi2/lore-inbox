Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSFKFsH>; Tue, 11 Jun 2002 01:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316837AbSFKFsG>; Tue, 11 Jun 2002 01:48:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316836AbSFKFsG>;
	Tue, 11 Jun 2002 01:48:06 -0400
Date: Mon, 10 Jun 2002 22:44:01 -0700 (PDT)
Message-Id: <20020610.224401.13280464.davem@redhat.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D058B41.6010601@pacbell.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Brownell <david-b@pacbell.net>
   Date: Mon, 10 Jun 2002 22:31:45 -0700

   One question is whether to support only one of them, or allow both.
   In either case the DMA-mapping.txt will need to touch on the issue.

Another important issue is from where do these issues originate?

This stuff rarely happens most of the time because block buffers and
networking buffers are what are fed to the chip.

I still think it is crucial that we not put this alignment garbage
into the drivers themselves.  Driver writers are going to get it
wrong or be confused by it.
