Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280609AbRKJLKE>; Sat, 10 Nov 2001 06:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280612AbRKJLJy>; Sat, 10 Nov 2001 06:09:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29265 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S280609AbRKJLJo>; Sat, 10 Nov 2001 06:09:44 -0500
Date: Sat, 10 Nov 2001 11:11:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <laughing@shared-source.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: cache acoounting in Linus tree
In-Reply-To: <20011110025722.A1526@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0111101101340.1542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Nov 2001, J . A . Magallon wrote:
> 
> Does Linus' tree need the cache accounting patch ? Listed below. Please,
> confirm or deny....
> 
> --- linux-2.4.13-ac5/fs/proc/proc_misc.c.blkpg	Wed Oct 31 13:09:51 2001
> +++ linux-2.4.13-ac5/fs/proc/proc_misc.c	Wed Oct 31 13:12:27 2001

Deny.  That's the patch Rik rightly posted for -ac, to remove some
code which was appropriate only to -linus, because of other changes
in -linus omitted from -ac: it fixed the meminfo Cached field in -ac.

The meminfo Cached field in -linus also sometimes went wrong.  Mike
Fedyk pursued that issue, Andrew Morton identified it as a wrong
line of code in the ext3 patch for -linus, and that line is not
(he has just assured us) in ext3 as it appears in 2.4.15-pre2.

So, no further patch required.

Hugh

