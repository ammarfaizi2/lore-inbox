Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287994AbSACAOf>; Wed, 2 Jan 2002 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSACANC>; Wed, 2 Jan 2002 19:13:02 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:16609 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288055AbSACAMm>;
	Wed, 2 Jan 2002 19:12:42 -0500
From: dewar@gnat.com
To: dewar@gnat.com, jbuck@synopsys.COM
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020103001241.E37DFF2EC6@nile.gnat.com>
Date: Wed,  2 Jan 2002 19:12:41 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<This is a modification to gcc that implements pointers as triples.
While there is a performance penalty for doing this, it can completely
eliminate the problem of exploitable buffer overflows.  However, programs
that violate the rules of ISO C by generating out-of-range pointers will
fail.
>>

Note incidentally that the C rules that allow referencing the address just
past the end of an array (an irregularity that recognizes the infeasibility
of declaring the common idiom for (a=b;a<&b[10];a++)) has an interesting
consequence on a segmented machine, namely that you cannot allocate an
array too near the end of the segment.
