Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDWWzw>; Mon, 23 Apr 2001 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDWWzm>; Mon, 23 Apr 2001 18:55:42 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:41989 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S132526AbRDWWy2>; Mon, 23 Apr 2001 18:54:28 -0400
Date: Mon, 23 Apr 2001 23:54:10 +0100 (BST)
From: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: <dwmw2@imladris.demon.co.uk>
To: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
cc: Matan Ziv-Av <matan@svgalib.org>, mythos <papadako@csd.uoc.gr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Can't compile 2.4.3 with agcc
In-Reply-To: <200104232232.AAA12700@kufel.dom>
Message-ID: <Pine.LNX.4.33.0104232349530.15177-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Andrzej Krzysztofowicz wrote:

> So maybe make the original error message more informative ?
> Just something like:
>
> -             extern void __buggy_fxsr_alignment(void);
> -             __buggy_fxsr_alignment();
> +             extern void __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy(void);
> +             __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy();

1. People would probably still report that to l-k instead of reading it.
2. It's still not guaranteed to compile, even with correct compilers.

Maybe you can do a post-processing step - a sanity check which is run
_after_ build. But the runtime check is sufficient. People won't randomly
start compiling kernels for production boxen with silly compilers, then
booting them unattended. And if they do, they deserve the downtime.

I agree that a compile-time check would be kinder, but only if it can be
done properly. Show me one, and I'll be happy.

-- 
dwmw2


