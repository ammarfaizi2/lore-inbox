Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSE1SGZ>; Tue, 28 May 2002 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316873AbSE1SGY>; Tue, 28 May 2002 14:06:24 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4113 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316860AbSE1SGX>;
	Tue, 28 May 2002 14:06:23 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205281806.g4SI6Nm216288@saturn.cs.uml.edu>
Subject: Re: changing __PAGE_OFFSET on x86?
To: fryman@cc.gatech.edu (Josh Fryman)
Date: Tue, 28 May 2002 14:06:23 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020528101515.56785de1.fryman@cc.gatech.edu> from "Josh Fryman" at May 28, 2002 10:15:15 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Fryman writes:

> when adding all this up, we're exceeding the 3G/1G split of the linux kernel.
> as dan maas pointed out, there should be a way to fix this in the kernel...
> so, after some grepping and code browsing, my new question is:
>
> to fix this, if we change the __PAGE_OFFSET in include/asm-i386/page.h from
> 0xc0000000 to 0xb000000, are there any hidden dependencies?  is there anything 
> else we need to worry about?  (does the __PAGE_OFFSET need to lie on a 1G
> boundary?)
>
> i haven't seen any, but them i'm not willing to say i understand all the 
> implications from chaging such a fundamental #define ....

At least at one time, the kernel side had to be a power of 2.
So you'd have to go to an even split if that's still the case.
