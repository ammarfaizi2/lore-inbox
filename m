Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKAIjH>; Wed, 1 Nov 2000 03:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbQKAIi4>; Wed, 1 Nov 2000 03:38:56 -0500
Received: from Cantor.suse.de ([194.112.123.193]:16650 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129118AbQKAIil>;
	Wed, 1 Nov 2000 03:38:41 -0500
Date: Wed, 1 Nov 2000 09:38:39 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001101093839.A16274@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 31, 2000 at 08:55:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 08:55:13PM +0000, Alan Cox wrote:
> 	What about the fact anyone can crash a box using ioctls on net
> 	devices and waiting for an unload - was this fixed ?

The ioctls of network devices are generally unsafe on SMP, because
they run with kernel lock dropped now but are mostly not safe to do so. 

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
