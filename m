Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267811AbUHJXKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267811AbUHJXKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUHJXKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:10:21 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:32718 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267811AbUHJXKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:10:09 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
	 <20040809212949.GA1120@elf.ucw.cz>
	 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
	 <1092130981.2676.1.camel@laptop.cunninghams>
	 <Pine.LNX.4.50.0408100655190.13807-100000@monsoon.he.net>
	 <1092176983.2709.3.camel@laptop.cunninghams>
	 <Pine.LNX.4.50.0408101544470.28789-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092179384.2711.29.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 11 Aug 2004 09:09:45 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-08-11 at 08:56, Patrick Mochel wrote:
> On Wed, 11 Aug 2004, Nigel Cunningham wrote:
> 
> > I'm not intending to patch the current implementation into the new
> > version; there are so many changes that it would make the process
> > extremely painful (as evolution would have been if it were really true).
> > Instead, I proposed, as Andrew requested to post a number of patches
> > simply adding the new version along side the old. When you're satisfied
> > that the new does everything the old does, I'm hoping we'll simply drop
> > the old version.
> 
> Then there is something seriously wrong with your development process.

No. It's just that the changes are so fundamental (how data is stored,
how we prepare the image etc) that to talk about evolution is simply a
misnomer. It's a redesign. The steps did occur one at a time, and there
are basic similarities, but some of the steps were fundamental rewrites.

> I'm sorry, but that's not how it works. There is no "flag day" for
> switching from one feature to the next, whether they are drivers, APIs, or
> suspend-to-disk implementations. And, I will definitely say, from
> experience, that adding a second competing implementation of anything to
> the kernel tree does little more than confuse users and developers.

I agree with the last bit, and I don't want a second competing design.
But there are flag days for some things, and multiple versions of some
code are found in the kernel (suspend until recently, e100/eepro100
driver...). This should be one of them.

Once it is merged, the period of co-existence should be short anyway.
Suspend 2 has had a ton of testing and is - dare I say it - virtually
bugfree. There should be no reason to delay its including in Linus'
tree.

> Making large changes to any piece of code is a long and tedious process,
> and takes a lot of practice. But, it is imperative for the other people
> working on it to be able to see improvements happen in steps, even if the
> steps number in the 100s.
> 
> For example, see the way in which Al Viro works. One day, some driver will
> be broken and unloved. Then Al will post a kajillion patches, each one
> modifying 1-10 lines and making complete, obvious sense. When it's all
> done, the result looks nothing like the original and the driver is
> race-free and beautiful.
> 
> Rome was not built in a day, and neither is good kernel code.

I'm not suggested it should be or that suspend2 was (it has been nearly
two years since I posted my first patch). But I am suggesting that the
process of working out bugs and thinking through design improvements has
already been done and tested. I'm perfectly willing to submit 16 or 30
patches, breaking up the changes into their main parts, but it is a
waste of your time and mine for me to break it up further than that.

That said, I'm sure there will also be suggestions that I can do some
things better. I look forward to them. But I don't look forward to
trying to break some of the irreducible changes down into artificially
distinguished component parts.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

