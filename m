Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbQJ2Bsh>; Sat, 28 Oct 2000 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130280AbQJ2Bs1>; Sat, 28 Oct 2000 21:48:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46475 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129535AbQJ2BsS>;
	Sat, 28 Oct 2000 21:48:18 -0400
Date: Sat, 28 Oct 2000 18:34:06 -0700
Message-Id: <200010290134.SAA08593@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: ak@suse.de
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20001029020311.A16003@gruyere.muc.suse.de> (message from Andi
	Kleen on Sun, 29 Oct 2000 02:03:11 +0100)
Subject: Re: tcp_do_sendmsg() allocation still broken ?
In-Reply-To: <Pine.LNX.4.21.0010281859570.865-100000@freak.distro.conectiva> <20001029020311.A16003@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sun, 29 Oct 2000 02:03:11 +0100
   From: Andi Kleen <ak@suse.de>

   tcp_do_sendmsg() should only be called from process context,
   because it can sleep for other reasons anyways.

   If someone calls it from interrupt context it needs to be fixed.

He is calling it from process context, he needs GFP_ATOMIC for
other reasons (VM deadlocks when using NBD).

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
