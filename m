Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTAGGkq>; Tue, 7 Jan 2003 01:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTAGGkq>; Tue, 7 Jan 2003 01:40:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267319AbTAGGkp>; Tue, 7 Jan 2003 01:40:45 -0500
Date: Mon, 6 Jan 2003 22:44:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Define hash_mem in lib/hash.c to apply hash_long to an
 arbitraty piece of memory.
In-Reply-To: <15898.24480.346258.361959@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0301062243590.10870-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Jan 2003, Neil Brown wrote:
> +	if (unlikely(IsLongAligned(buf))) {
> +
> +		/* Some architectures don't like dereferencing a long
> +		 * pointer that isn't aligned, so we do it by hand...
> +		 */
> +		while (len >= BYTES_PER_LONG) {
> +			memcpy(&l, buf, BYTES_PER_LONG);

Ugh. What a crock.

This is what we have "get_unaligned()" for.

		Linus

