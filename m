Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318968AbSIJBiP>; Mon, 9 Sep 2002 21:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318976AbSIJBiP>; Mon, 9 Sep 2002 21:38:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48305 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318968AbSIJBiO>;
	Mon, 9 Sep 2002 21:38:14 -0400
Date: Mon, 9 Sep 2002 21:42:58 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.34 ufs/super.c
In-Reply-To: <Pine.LNX.4.33.0209091341550.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0209092139520.4087-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Sep 2002, Linus Torvalds wrote:

> 
> This patch is definitely correct, but on the other hand I really think
> that the calling convention of sb_set_blocksize() is wrong, and instead of
> returning "size for success or zero for failure ", it should return "error
> code for failure or zero for success".
> 
> There's just no point to returning the same size we just passed in.
> 
> And making that calling convention the new one would make the current UFS
> code be the _right_ one.
> 
> Al, comments? Why the strange calling convention?

No particulary good reason, except keeping calling convention the same for
sb_set_blocksize() and sb_min_blocksize()...

