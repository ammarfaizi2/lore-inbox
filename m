Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287924AbSA3COO>; Tue, 29 Jan 2002 21:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287979AbSA3COF>; Tue, 29 Jan 2002 21:14:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30476 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287924AbSA3CNy>; Tue, 29 Jan 2002 21:13:54 -0500
Date: Tue, 29 Jan 2002 18:12:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: <20020130130026.13803fda.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0201291801550.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Rusty Russell wrote:
>
> Boots and runs: more cleanups will follow once this is in...

May I suggest a few more cleanups before I apply it, namely try to
abstract out that "&__per_cpu_end-&__per_cpu_start" thing and make it more
readable what is going on in setup_per_cpu_areas() which (quite frankly)
is otherwise a prime candidate for the obfuscated C contest.

Also, wouldn't it be much nicer to just leave CPU#0 at the start of
.data.percpu, and not have to have an offset for CPU0 at all? That would
sure make the UP case cleaner.

		Linus

