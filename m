Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSLFQ2q>; Fri, 6 Dec 2002 11:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbSLFQ2q>; Fri, 6 Dec 2002 11:28:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21508 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263491AbSLFQ2p>; Fri, 6 Dec 2002 11:28:45 -0500
Date: Fri, 6 Dec 2002 08:37:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Bader <miles@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Make `hash_long' function work if bits parameter is 0.
In-Reply-To: <20021206093351.9413736F6@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0212060836170.23118-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 6 Dec 2002, Miles Bader wrote:
>
> If the bits parameter of hash_long (in <linux/hash.h>) is 0, then it
> ends up right-shifting by BITS_PER_LONG, which is undefined in C (and
> often is a nop).

I would much rather just add a comment saying that "bits" had better be in
a valid range. There are no valid uses for a 0-bit hash table that I can
see, and undefined behaviour for undefined operations is fine with me.

		Linus

