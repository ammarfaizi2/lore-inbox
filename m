Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291449AbSBAAVr>; Thu, 31 Jan 2002 19:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291450AbSBAAVh>; Thu, 31 Jan 2002 19:21:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56338 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291449AbSBAAVY>; Thu, 31 Jan 2002 19:21:24 -0500
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
To: anton@samba.org (Anton Blanchard)
Date: Fri, 1 Feb 2002 00:34:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), riel@conectiva.com.br (Rik van Riel),
        torvalds@transmeta.com (Linus Torvalds),
        davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <20020131234416.GB4138@krispykreme> from "Anton Blanchard" at Feb 01, 2002 10:44:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WReX-0003gt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the prefetch engine will have to restart every 4kB, so we would want to
> use 16MB pages if possible.
> 
> How would we allocate large pages? Would there be a boot option to
> reserve an area of RAM for large pages only?

If you have an rmap all you have to do is to avoid smearing kernel objects
around lots of 16Mb page sets. If need be you can then get a 16Mb page
back just by shuffling user pages.

It does make the performance analysis much more interesting though.
