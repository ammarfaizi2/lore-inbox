Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUAOBpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUAOBmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:42:43 -0500
Received: from unthought.net ([212.97.129.88]:5831 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263510AbUAOBmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:42:09 -0500
Date: Thu, 15 Jan 2004 02:42:07 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040115014207.GF22216@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
References: <40033D02.8000207@adaptec.com> <20040113162636.GT346@unthought.net> <20040113201058.GD1594@srv-lnx2600.matchmail.com> <20040114190701.GD22216@unthought.net> <20040114194052.GK1594@srv-lnx2600.matchmail.com> <20040114210258.GE22216@unthought.net> <20040114222447.GL1594@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114222447.GL1594@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 02:24:47PM -0800, Mike Fedyk wrote:
...
> > "only" adding disks... How many people actually shrink stuff nowadays?
> > 
> 
> Going raid0 -> raid5 would shrink your filesystem.

Not if you add an extra disk  :)

> 
> > I'd say having hot-growth would solve 99% of the problems out there.
> > 
> 
> True.  Until now I didn't know I could resize my MD raid arrays!
> 
> Is it still true that you think it's a good idea to try to test the resizing
> code?  It's been around since 1999, so maybe it's a bit further than
> "experemental" now?

I haven't had much need for the program myself since shortly after I
wrote it, but maybe a handfull or so of people have tested it and
reported results back to me (and that's since 1999!).

RedHat took the tool and shipped it with some changes. Don't know if
they have had feedback...

>From the testing it has had, I wouldn't call it more than experimental.
As it turns out, it was "almost" correct from the beginning, and there
haven't been much progress since then  :)

Now it's just lying on my site, rotting...   Mostly, I think the problem
is that the reconfiguration is not on-line.  It is not really useful to
do off-line reconfiguration. You need to make a full backup anyway - and
it is simply faster to just re-create the array and restore your data,
than to run the reconfiguration.  At least this holds true for most of
the cases I've heard of (except maybe the ones where users didn't back
up data first).

I think it's a pity that noone has taken the code and somehow
(userspace/kernel hybrid or pure kernel?) integrated it with the kernel
to make hot reconfiguration possible.

But I have not had the time to do so myself, and I cannot see myself
getting the time to do it in any forseeable future.

I aired the idea with the EVMS folks about a year ago, and they like the
idea but were too busy just getting EVMS into the kernel as it was,
making the necessary changes there...

I think most people agree that hot reconfiguration of RAID arrays would
be a cool feature.  It just seems that noone really has the time to do
it.   The logic as such should be fairly simple - raidreconf is maybe
not exactly 'trivial', but it's not rocket science either.  And if
nothing else, it's a skeleton that works (mostly)   :)

> 
> Has anyone tried to write a test suite for it?

Not that I know of.  But a certain commercial NAS vendor used the tool
in their products, so maybe they wrote a test suite, I don't know.

 / jakob

