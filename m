Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278713AbRJ2Xqa>; Mon, 29 Oct 2001 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279350AbRJ2XqU>; Mon, 29 Oct 2001 18:46:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30214 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278713AbRJ2XqG>; Mon, 29 Oct 2001 18:46:06 -0500
Date: Mon, 29 Oct 2001 15:44:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029182949.H25434@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291542350.16703-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Benjamin LaHaise wrote:
>
> Think of CPUs with tagged tlbs and lots of entries.  Or even a system that
> only runs 1 threaded app.  Easily triggerable.  If people want to optimise
> it, great.  But go for correctness first, please...

"easily triggerable"?

I doubt you'll find _any_ system where you can trigger it. Think about it:
in order to get the kind of VM pressure that causes page-outs, your TLB
pressure will be a lot higher than _any_ CPU I have ever heard about.

256 TLB entries is considered "a lot". Tagged or not, if the VM pressure
is so big that we need to swap, those 256 entries are a grain of sand in
sahara.

		Linus

