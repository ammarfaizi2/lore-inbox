Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTBXHmb>; Mon, 24 Feb 2003 02:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTBXHmb>; Mon, 24 Feb 2003 02:42:31 -0500
Received: from holomorphy.com ([66.224.33.161]:37807 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264925AbTBXHm3>;
	Mon, 24 Feb 2003 02:42:29 -0500
Date: Sun, 23 Feb 2003 23:51:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030224075142.GA10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302221417120.2686-100000@coffee.psychology.mcmaster.ca> <1510000.1045942974@[10.10.2.4]> <20030222195642.GI1407@work.bitmover.com> <2080000.1045947731@[10.10.2.4]> <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224065826.GA5665@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 10:58:26PM -0800, Larry McVoy wrote:
> Linux is a really fast system right now.  The code paths are short and
> it is possible to use the OS almost as if it were a library, the cost is
> so little that you really can mmap stuff in as you need, something that
> people have wanted since Multics.  There will always be many more uses
> of Linux in small systems than large, simply because there will always
> be more small systems.  Keeping Linux working well on small systems is
> going to have a dramatically larger positive benefit for the world than
> scaling it to 64 processors.  So who do you want to help?  An elite
> few or everyone?

I don't know what kind of joke you think I'm trying to play here.

"Scalability" is about making the kernel properly adapt to the size of
the system. This means UP. This means embedded. This means mid-range
x86 bigfathighmem turds. This means SGI Altix. I have _personally_
written patches to decrease the space footprint of pidhashes and other
data structures so that embedded systems function more optimally.

It's not about crapping all over the low end. It's not about degrading
performance on commonly available systems. It's about increasing the
range of systems on which Linux performs well and is useful.

Maintaining the performance of Linux on commonly available systems is
not only deeply ingrained as one of a set of personal standards amongst
all kernel hackers involved with scalability, it's also a prerequisite
for patch acceptance that is rigorously enforced by maintainers. To
further demonstrate this, look at the pgd_ctor patches, which markedly
reduced the overhead of pgd setup and teardown on UP lowmem systems and
were very minor improvements on PAE systems.

Now it's time to turn the question back around on you. Why do you not
want Linux to work well on a broader range of systems than it does now?


-- wli
