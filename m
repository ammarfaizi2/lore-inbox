Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTBXX10>; Mon, 24 Feb 2003 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTBXX10>; Mon, 24 Feb 2003 18:27:26 -0500
Received: from holomorphy.com ([66.224.33.161]:25779 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261874AbTBXX1Z>;
	Mon, 24 Feb 2003 18:27:25 -0500
Date: Mon, 24 Feb 2003 15:36:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224233638.GS10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224154725.GB5665@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:51:42PM -0800, William Lee Irwin III wrote:
>> Now it's time to turn the question back around on you. Why do you not
>> want Linux to work well on a broader range of systems than it does now?

On Mon, Feb 24, 2003 at 07:47:25AM -0800, Larry McVoy wrote:
> I never said that I didn't.  I'm just taking issue with the choosen path
> which has been demonstrated to not work.
> "Let's scale Linux by multi threading"
>     "Err, that really sucked for everyone who has tried it in the past, all
>     the code paths got long and uniprocessor performance suffered"
> "Oh, but we won't do that, that would be bad".
>     "Great, how about you measure the changes carefully and really show that?"
> "We don't need to measure the changes, we know we'll do it right".

The changes are getting measured. By and large if it's slower on UP
it's rejected. There's a dedicated benchmark crew, of which Randy Hron
is an important member, that benchmarks such things very consistently.
Internal benchmarking includes both free and non-free benchmarks. dbench,
tiobench, kernel compiles, contest, and so on are the publicable bits.

Also, code paths are also not necessarily getting longer. Single-
threaded efficiency lowers lock hold time and helps small systems too,
and numerous improvements with buffer_heads, task searching, file
truncation, and the like, are of that flavor.


On Mon, Feb 24, 2003 at 07:47:25AM -0800, Larry McVoy wrote:
> And just like in every other time this come up in every other engineering
> organization, the focus is in 2x wherever we are today.  It is *never*
> about getting to 100x or 1000x.
> If you were looking at the problem assuming that the same code had to
> run on uniprocessor and a 1000 way smp, right now, today, and designing
> for it, I doubt very much we'd have anything to argue about.  A lot of
> what I'm saying starts to become obviously true as you increase the 
> number of CPUs but engineers are always seduced into making it go 2x 
> farther than it does today.  Unfortunately, each of those 2x increases
> comes at some cost and they add up.

Linux is a patchwork kernel. No coherent design will ever shine through.
Scaling the kernel incrementally merely becomes that much more difficult.
The small system performance standards aren't getting lowered.

Also note there are various efforts to scale the kernel _downward_ to
smaller embedded systems, partly by controlling "bloated" hash tables'
sizes and partly by making major subsystems optional and partly by
supporting systems with no MMU. This is not a one-way street, though I
myself am clearly pointed in the upward direction.


-- wli
