Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRDXIx7>; Tue, 24 Apr 2001 04:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132797AbRDXIxk>; Tue, 24 Apr 2001 04:53:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131820AbRDXIxc>;
	Tue, 24 Apr 2001 04:53:32 -0400
Date: Tue, 24 Apr 2001 09:53:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>,
        Matan Ziv-Av <matan@svgalib.org>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc
Message-ID: <20010424095304.A2389@flint.arm.linux.org.uk>
In-Reply-To: <200104232232.AAA12700@kufel.dom> <Pine.LNX.4.33.0104232349530.15177-100000@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104232349530.15177-100000@imladris.demon.co.uk>; from dwmw2@infradead.org on Mon, Apr 23, 2001 at 11:54:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:54:10PM +0100, David Woodhouse wrote:
> On Tue, 24 Apr 2001, Andrzej Krzysztofowicz wrote:
> > -             extern void __buggy_fxsr_alignment(void);
> > -             __buggy_fxsr_alignment();
> > +             extern void __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy(void);
> > +             __BUG__task_struct__data_is_not_properly_alligned__Probably_your_compiler_is_buggy();
> 
> 1. People would probably still report that to l-k instead of reading it.
> 2. It's still not guaranteed to compile, even with correct compilers.
> 
> Maybe you can do a post-processing step - a sanity check which is run
> _after_ build. But the runtime check is sufficient. People won't randomly
> start compiling kernels for production boxen with silly compilers, then
> booting them unattended. And if they do, they deserve the downtime.

grep '__BUG__' System.map | cut -d\  -f3

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

