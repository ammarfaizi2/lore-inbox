Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270664AbRHJWna>; Fri, 10 Aug 2001 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270666AbRHJWnU>; Fri, 10 Aug 2001 18:43:20 -0400
Received: from four.malevolentminds.com ([216.177.76.238]:11024 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S270664AbRHJWnK>; Fri, 10 Aug 2001 18:43:10 -0400
Date: Fri, 10 Aug 2001 15:43:15 -0700 (PDT)
From: Khyron <khyron@khyron.com>
X-X-Sender: <khyron@four.malevolentminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PROBLEM] 2.4.5: Sending TCP doesn't send
Message-ID: <Pine.BSF.4.33.0108100143060.92008-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if anyone has seen this (or if its even really
a problem), but I have 2 servers running patched 2.4.5 kernels.
For completeness, the patches are XFS 06042001 and JFS 0.3.4.
ReiserFS and IPChains are compiled in.

Anyway, the problem is that the sending TCP continues to
accumulate data in the send buffer (which has been increased
to 2 MB) w/o sending it. This is causing our custom application
to hang, and we expect to see (but haven't yet seen) the buffer
overflow.

The scenario is that the sending TCP has stops sending, plain
and simple. This only seems to occur with packets of about 4K
and larger.

I am not the developer who recognized this issue, but I am
trying to find out if anyone else has noticed this type of
behavior and how we might deal with it.

If more information is required, let me know and I"ll see what I
can do. I am planning on integrating a kernel debugger and maybe
even SGI's kernel profiling, but I don't know how effective either
of these approaches could be in solving this problem.

Thoughts, suggestions and questions welcome, as I have no idea
how to attack this problem correctly.

TIA!

////////////////////////////////////////////////////////////////////
Khyron					    mailto:khyron@khyron.com
Key fingerprint = 53BB 08CA 6A4B 8AF8 DF9B  7E71 2D20 AD30 6684 E82D
			"Drama free in 2001!"
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\



