Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVADQMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVADQMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVADQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:10:58 -0500
Received: from holomorphy.com ([207.189.100.168]:26248 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261713AbVADQJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:09:31 -0500
Date: Tue, 4 Jan 2005 07:58:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <willy@w.ods.org>, Thomas Graf <tgraf@suug.ch>,
       "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Diego Calleja <diegocg@teleline.es>, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104155844.GI2708@holomorphy.com>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk> <20050104002452.GA8045@thunk.org> <20050104031229.GE26856@postel.suug.ch> <20050104053348.GB19945@alpha.home.local> <20050104152136.GE3097@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104152136.GE3097@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 06:33:48AM +0100, Willy Tarreau wrote:
>> These two problems are solvable with the same solution : no rc anymore.
>> I agree with Ted. A version every week or 2 weeks is good. People will
>> run random versions, some will report problems, others not. After that,
>> you know the differences between exact releases, you don't have to parse
>> 28 MB changes. And you can also ask them to upgrade or downgrade and
>> quickly find where the bug entered.

On Tue, Jan 04, 2005 at 04:21:36PM +0100, Adrian Bunk wrote:
> This was the model for development kernels, and it's usable for 
> development kernels.
> The problem is that 28 MB in 9 weeks are 3 MB of changes every week.
> With such a weekly model, I fear the weekly kernels would be of very 
> varying quality and never fully stable. Up to 2.4, kernel.org kernels 
> were usually a good choice, but with such a model the only usable 
> kernels in production environments will be distribution kernels that 
> will contain the mixture of at least three "stable" kernel for getting a 
> usable kernel.

You could in principle base version numbers on external influences. In a
5-point decimal system, then 2.6.x.y.z would be released daily, 2.6.x.y.0
released every 10 days, 2.6.x.0.0 released every 100 days, and 2.7.0.0.0
released after 1000 days, and so on.

Similarly for patches instead of days; an 8-point decimal system could
be released based on the number of patches merged. 2.6.u.v.w.x.y.z
would be "released" for every patch merged, 2.6.u.v.w.x.y.0 released
for every 10 patches, 2.6.u.v.w.x.0.0 released for every 100 patches,
2.6.u.v.w.0.0.0 for every 1000 patches, 2.6.u.v.0.0.0.0 released after
10000 patches, 2.6.u.0.0.0.0.0 released after 100000 patches, and
2.7.0.0.0.0.0 released after 1000000 patches. Or perhaps a natural
number merely counting the number of patches merged suffices.

In both decimal systems, 0 <= u, v, w, x, y, z < 10.

This will ultimately be defeated by anticipatory behavior regarding
magic numbers (lots of 0's) and divergent trees, though I actually sort
of like the 8-point decimal system based on patches merged or otherwise
counting the number of patches merged, since it would provide a method
of referring to all states of the tree, enabling binary search for bugs.

But I highly doubt anything of these kinds will happen, and they're
largely orthogonal to the issue of users being scared of how big the
tree has gotten and not being able to understand that large numbers of
patches must be interpreted relative to the size of the codebase
instead of in absolute terms.


-- wli
