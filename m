Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTAKFbv>; Sat, 11 Jan 2003 00:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAKFbv>; Sat, 11 Jan 2003 00:31:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4360 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267079AbTAKFbu>; Sat, 11 Jan 2003 00:31:50 -0500
Date: Fri, 10 Jan 2003 21:36:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Richard Henderson <rth@twiddle.net>, Miles Bader <miles@gnu.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX
 is non-empty 
In-Reply-To: <20030111050918.99C762C04F@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301102134150.9532-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jan 2003, Rusty Russell wrote:
> 
> Just in case someone names a variable over 2000 chars, and uses it as
> an old-style module parameter?

No. Just because variable-sized arrays aren't C, and generate crappy code.

>  	for (i = 0; i < num; i++) {
> +		char sym_name[strlen(obsparm[i].name)
> +			     + sizeof(MODULE_SYMBOL_PREFIX)];

It's still there.

		Linus

