Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSBYTd3>; Mon, 25 Feb 2002 14:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293452AbSBYTdU>; Mon, 25 Feb 2002 14:33:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293448AbSBYTdH>; Mon, 25 Feb 2002 14:33:07 -0500
Date: Mon, 25 Feb 2002 11:31:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16fPWS-0005hU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202251129480.8991-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Feb 2002, Alan Cox wrote:
> 
> Ok I see where you are coming from now -- that makes sense for a few cases.

Note that the "few cases" in question imply _all_ of the current broken 
library spinlocks, for example. 

Don't think "POSIX semaphores", but think "fast locking" in the general
case. I will bet you $1 in small change that most normal locking by far is
for the kind of thread-safe stuff libc does right now.

		Linus

