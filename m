Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbTL0Xui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 18:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbTL0Xui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 18:50:38 -0500
Received: from holomorphy.com ([199.26.172.102]:52912 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264881AbTL0Xuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 18:50:37 -0500
Date: Sat, 27 Dec 2003 15:50:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Message-ID: <20031227235016.GB22503@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Anton Ertl <anton@mips.complang.tuwien.ac.at>,
	linux-kernel@vger.kernel.org
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it> <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org> <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1smj596t1.fsf@ebiederm.dsl.xmission.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>> Basically: prove me wrong. People have tried before. They have failed. 
>> Maybe you'll succeed. I doubt it, but hey, I'm not stopping you.

On Sat, Dec 27, 2003 at 04:31:22PM -0700, Eric W. Biederman wrote:
> For anyone taking you up on this I'd like to suggest two possible
> directions.
> 1) Increasing PAGE_SIZE in the kernel.
> 2) Creating zones for the different colors.  Zones were not
>    implemented last time, this was tried.
> Both of those should be minimal impact to the complexity
> of the current kernel. 
> I don't know where we will wind up but the performance variation's
> caused by cache conflicts in today's applications are real, and easily
> measurable.  Giving the growing increase in performance difference
> between CPUs and memory Amdahl's Law shows this will only grow
> so I think this is worth looking at.

Increasing PAGE_SIZE in the kernel either (a) breaks ABI or (b) is
nontrivial. I suppose I should try some of the page coloring benchmarks
on pgcl (which preserves ABI).

-- wli
