Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132257AbQLQEVY>; Sat, 16 Dec 2000 23:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132303AbQLQEVO>; Sat, 16 Dec 2000 23:21:14 -0500
Received: from p050.as-l001.contactel.cz ([212.65.194.50]:15876 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S132257AbQLQEU4>;
	Sat, 16 Dec 2000 23:20:56 -0500
Date: Sun, 17 Dec 2000 04:49:20 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Message-ID: <20001217044920.H410@ppc.vc.cvut.cz>
In-Reply-To: <20001217034928.A410@ppc.vc.cvut.cz> <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012161859340.23256-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 16, 2000 at 07:09:56PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 07:09:56PM -0800, Linus Torvalds wrote:
> 				
> which basically will never re-start at the head if a tq re-inserts iself
> (side note: new entires are inserted at the end, but if it was already the
> last entry then re-inserting it will not re-execute it, should this should
> avoid your problem).
> 
> Does this fix the problem for you?

It looks like that it does. I hope that there are not two such users in
kernel, as if they are, it can loop again.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
