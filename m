Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278298AbRJMORG>; Sat, 13 Oct 2001 10:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278301AbRJMOQ4>; Sat, 13 Oct 2001 10:16:56 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:60803 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S278298AbRJMOQt>;
	Sat, 13 Oct 2001 10:16:49 -0400
Date: Sat, 13 Oct 2001 16:17:14 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110131417.QAA25601@harpo.it.uu.se>
To: davej@suse.de
Subject: Re: [PATCH] Pentium IV cacheline size.
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001 12:57:33 +0100, Dave Jones wrote:
>Currently, we're using a L1_CACHE_SHIFT value of 7
>for Pentium 4, which equates to 128 byte cache lines.
>Curious, I dumped the info on the only P4 I could find,
>and noticed they were 64 byte.
>Upon checking the documentation, they're 64 byte there too. 
>Is this just a thinko on someones part, or was there a
>rationale behind this that I've not realised ?

According to the P4 and Xeon optimisation manual (#248966-03), the
L1 cache has a 64-byte line size and the L2 cache has a 128-byte
line size. (Page 1-18, Table 1-1.) Perhaps someone just confused
the two, or the distinction wasn't known when the initial P4
support was added to the kernel.

/Mikael
