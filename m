Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbTBXTb3>; Mon, 24 Feb 2003 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbTBXTb3>; Mon, 24 Feb 2003 14:31:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:22147 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267106AbTBXTb2>; Mon, 24 Feb 2003 14:31:28 -0500
Date: Mon, 24 Feb 2003 14:44:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <200302241910.51523.schwidefsky@de.ibm.com>
Message-ID: <Pine.LNX.3.95.1030224143236.14614A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Martin Schwidefsky wrote:

> updates for compiling with gcc-3.3pre
> 

[SNIPPED...]
> - Don't warn about signed/unsigned comparisions

I think you must keep these warnings in! There are many bugs
that these uncover uncluding loops that don't terminate correctly
but seem to work for "most all" cases. These are the hard-to-find
bugs that hit you six months after release.

size_t i;

   while((i = do_forever()) > 0)
          ;

... do_forever() finally errors out and returns -1 stuck(forever).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


