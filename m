Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285823AbRLJTgq>; Mon, 10 Dec 2001 14:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286184AbRLJTgg>; Mon, 10 Dec 2001 14:36:36 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52145 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S285823AbRLJTgb>;
	Mon, 10 Dec 2001 14:36:31 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Dec 2001 19:36:14 GMT
Message-Id: <UTC200112101936.TAA283032.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: Linux/Pro  -- clusters
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Mon Dec 10 17:50:02 2001

    Basically you propose to take the current system, replace it with
    something without clear memory management ("let it leak") and then
    try to fix the resulting mess.

Al - you are using debating tricks instead of logic, using
negative words ("unclear", "leak", "mess") instead of arguments.
Maybe you are unable to refute the soundness of the system I propose?

It is quite possible that I overlook some detail.
On the other hand, I have been running these systems.
You are not able to convince me that something is wrong
just by handwaving. Real arguments are required.


What I do is go from the present situation, in a series of steps,
to a new situation where the source looks different but the
system behaves provably the same. Consequently, no "fixing"
is required. "Mess" is a matter of taste, I'll not discuss that
except by saying that I vastly prefer the situation without arrays.
"Leak" is false. "Dangling pointers" is false.

Andries


[About "leak": What happens today is that a driver like sd.c
allocates arrays and fills them. In my version this driver
allocates structures and fills them. When the module is removed,
today the arrays are freed. In my version the structures are
freed at that point. So, no leakage occurs.
About "dangling pointers": The correctness condition for this
scheme is that no struct that contains kdev_t fields survives
removal of the module.
It seems to me that that is true already, and in any case will
be easy to ensure. If you have other opinions, please come
with explicit examples where fundamental problems would occur.]

[and, Linus, the name of the beast makes no difference; kdev_t
or kbdev_t or struct block_device *; it is the same amount of work]
