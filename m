Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSFKHtm>; Tue, 11 Jun 2002 03:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFKHrn>; Tue, 11 Jun 2002 03:47:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64706 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316898AbSFKHr0>;
	Tue, 11 Jun 2002 03:47:26 -0400
Date: Tue, 11 Jun 2002 00:43:05 -0700 (PDT)
Message-Id: <20020611.004305.96601553.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020611.003625.05877183.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Tue, 11 Jun 2002 00:36:25 -0700 (PDT)

   The DMA_ALIGN attribute doesn't work, on some systems the PCI
   cacheline size is determined at boot time not compile time.

Another note, it could be per-PCI controller what this cacheline size
is.  We'll need to pass in a pdev to the alignment interfaces to
do this correctly.

So none of this can be done at compile time folks.
