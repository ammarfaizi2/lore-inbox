Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281191AbRKHAso>; Wed, 7 Nov 2001 19:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281220AbRKHAsY>; Wed, 7 Nov 2001 19:48:24 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:42247 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281210AbRKHAsU>;
	Wed, 7 Nov 2001 19:48:20 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111080047.fA80lxk105204@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: linux-kernel@alex.org.uk
Date: Wed, 7 Nov 2001 19:47:58 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        viro@math.psu.edu (Alexander Viro), jfbeam@bluetopia.net (Ricky Beam),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk),
        linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <1832004393.1005153898@[10.132.113.67]> from "Alex Bligh - linux-kernel" at Nov 07, 2001 05:24:58 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux writes:

>    sure it's easier to strip out a spurious 'kb' that
>    gets added after a number, than to deal with (say)
>    an extra inserted DWORD with no version traching.

Design the kernel to make doing this difficult.
Define some offsets as follows:

#define FOO_PID 0
#define FOO_PPID 1

Now, how is anyone going to create "an extra inserted DWORD"
between those? They'd need to renumber FOO_PPID and any other
values that come after it.

The "DWORD" idea is messed up too BTW. Use __u64 everywhere.
