Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTBSTXJ>; Wed, 19 Feb 2003 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTBSTXJ>; Wed, 19 Feb 2003 14:23:09 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9352 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263794AbTBSTXI>; Wed, 19 Feb 2003 14:23:08 -0500
Date: Wed, 19 Feb 2003 14:36:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mark Frazer <mark@somanetworks.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: more than 2048 unix98 ptys?
In-Reply-To: <20030219141537.A21814@somanetworks.com>
Message-ID: <Pine.LNX.3.95.1030219143104.10649A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Mark Frazer wrote:

> Is there a patch out there to allow more than 2048 unix98 ptys on
> a single box?
> 
> thanks
> -mark
> 
> -- 

Read the comments in .../linux-n.n/include/linux/tty.h and then
modify NR_PTYS accordingly. You need to add more majors as well.

Note that ptys are used for interactive terminals, you don't need
one for every network connection. You may be adding something that
you don't need and wasting kernel space.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


