Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286756AbSA2XUD>; Tue, 29 Jan 2002 18:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSA2XSw>; Tue, 29 Jan 2002 18:18:52 -0500
Received: from waste.org ([209.173.204.2]:52193 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S286712AbSA2XRg>;
	Tue, 29 Jan 2002 18:17:36 -0500
Date: Tue, 29 Jan 2002 17:17:04 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: <E16VU8j-0006Hm-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0201291713090.25443-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Rusty Russell wrote:

> This patch introduces the __per_cpu_data tag for data, and the
> per_cpu() & this_cpu() macros to go with it.
>
> This allows us to get rid of all those special case structures
> springing up all over the place for CPU-local data.

Seems like we could do slightly better to have these local areas mapped to
the same virtual address on each processor, which does away with the need
for an entire level of indirection.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

