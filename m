Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSLPKT7>; Mon, 16 Dec 2002 05:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSLPKTB>; Mon, 16 Dec 2002 05:19:01 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:17682 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266615AbSLPKSs>; Mon, 16 Dec 2002 05:18:48 -0500
Date: Mon, 16 Dec 2002 10:26:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>, bcollins@debian.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
Message-ID: <20021216102639.A27589@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, bcollins@debian.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212151930120.12906-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 15, 2002 at 07:34:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2002 at 07:34:09PM -0800, Linus Torvalds wrote:
> Ben Collins <bcollins@debian.org>:
>   o IEEE-1394/Firewire update

This merge looks fishy.  It seems to be yet another let's throw my CVS
repo in merge and backs out Al's work yo get rid of lots of devfs crap.

It also contains strange changes like:

-	ch = kmalloc(sizeof *ch, SLAB_KERNEL);
+	ch = kmalloc(sizeof *ch, in_interrupt() ? SLAB_ATOMIC : SLAB_KERNEL);

that really want proper fixing.

