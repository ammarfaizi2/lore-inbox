Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUJWOWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUJWOWM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUJWOWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:22:12 -0400
Received: from holomorphy.com ([207.189.100.168]:33484 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261190AbUJWOV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:21:57 -0400
Date: Sat, 23 Oct 2004 07:18:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Adrian Bunk <bunk@stusta.de>, espenfjo@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041023141833.GN17038@holomorphy.com>
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local> <20041023014004.GG22558@stusta.de> <20041023055212.GA21206@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023055212.GA21206@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
>> 2.6.9 -> 2.6.10-rc1:
>> - 4 days
>> - > 15 MB patches

On Sat, Oct 23, 2004 at 07:52:12AM +0200, Willy Tarreau wrote:
> I firmly agree, and that's one of the reasons I still don't use 2.6. This
> could be avoided with a shorter release cycle with far less new features
> for each version (a bit like openbsd does), because about every maintainer
> would have a valid base to work on for the next release or the one after,
> and would not try to push unstable code in the "stable" kernel. Today, lots
> of people are certain that 2.8 (or 3.0) won't be out before 3 or 4 years. So
> if they want their code released soon, they push it hard in the current
> mainline :-(

The kernel is a big program. Your sense of scale is off.


On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
>> It's a bit optimistic to call this amount of change "stabilizing".

On Sat, Oct 23, 2004 at 07:52:12AM +0200, Willy Tarreau wrote:
> What really frightens me is that judging from the changelogs, it really
> looks like cleanups, bug fixes and sometimes core changes... This gives
> a terrible idea of previous release code !

If you're expecting something different, perhaps your expectations are
off. Cleanups matter because they make maintenance easier. Core changes
happen because (gasp!) sometimes the core too has bugs or other issues.


On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
>> 2.6 is corrently more a development kernel than a stable kernel.

On Sat, Oct 23, 2004 at 07:52:12AM +0200, Willy Tarreau wrote:
> That's how I present it to friends and customers too ;-) To others, I simply
> say that it's the new stable kernel, and I observe how it works for them :-)

I could show you what kinds of changes go in a development kernel as
opposed to what's going on in 2.6, but I have other things to do.


On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
>> The last bug I observed personally was the problem with suspending when 
>> using CONFIG_REGPARM=y together with Roland's waitid patch which was 
>> added in 2.6.9-rc2. If I'd used 2.6.9 with the same .config as 2.6.8.1, 
>> this was simple one more bug...

On Sat, Oct 23, 2004 at 07:52:12AM +0200, Willy Tarreau wrote:
> Each time I try a new release, I barely find it extremely slow and unstable,
> and I don't know where to start from to report broken things... Unfortunately
> I don't have enough time to spend on bug reports these days so I stick to a
> stable 2.4.

"Extremely slow and unstable" is so vague it can't be acted upon. How
do you expect anyone to provide a useful response to that kind of
problem description?


On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
>> IMHO Andrew+Linus should open a short-living 2.7 tree soon and Andrew 
>> (or someone else) should maintain a 2.6 tree with less changes (like 
>> Marcelo did and does with 2.4).

On Sat, Oct 23, 2004 at 07:52:12AM +0200, Willy Tarreau wrote:
> Yes, but not until the core is stabilized. Otherwise, ever changing
> features and exports will discourage driver maintainers from
> backporting fixes.

Your notion of the core being stabilized must be intractably strict.
There are, for instance, no changes comparable to converting the block
layer to use bio, or removing the global irq lock.


-- wli
