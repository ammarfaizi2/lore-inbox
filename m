Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVACWRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVACWRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVACWQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:16:42 -0500
Received: from holomorphy.com ([207.189.100.168]:65438 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261912AbVACWNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:13:17 -0500
Date: Mon, 3 Jan 2005 14:09:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103220937.GT29332@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103123325.GV29332@holomorphy.com> <20050103213845.GA18010@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103213845.GA18010@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>> This is bizarre. iptables was made the de facto standard in 2.4.x and
>> the alternatives have issues with functionality. The 2.0/2.2 firewalling
>> interfaces are probably ready to go regardless. You do realize this is
>> what you're referring to?
>> 2 major releases is long enough.

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> if it's long enough, ipfwadm should not have entered 2.6 at all. It's
> not because you don't see any use to that particular feature that you
> can guarantee that it is not used at all. At least, a large public
> call to get in touch with the potentially unique user of this feature
> would be a start, but generally we should not remove a feature from a
> stable kernel. What will go next ? minix, because someone will decide
> that there have been many better filesystems for a long time, so
> that's long enough ? Revert modules to modutils because someone
> will think it's simpler for everyone to use a single toolset ? I have
> no problem removing numerous feature between major releases, even
> breaking APIs, but I really hate it when something which is called
> "stable" constantly changes.

Unfortunately you're never going to find a rock to build your house
on. there is no rock, there is only shifting sand.


On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>> Who do you think is actually banging out the code on this mailing list?

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> Frankly, sometimes I'm really wondering. We see lots of very clever
> ideas, and sometimes people come up with concepts which can break
> existing apps, and simply justify by "this should not have been done
> in the first time." (eg: unexport syscall_table). But I'm certain
> that all these mistakes are caused by those too long development
> cycles. Some developpers get bored by things that irritate them, and
> prefer to fix the stable tree to stop what they believe is an error,
> instead of waiting for the next release to fix it there.

These things are harder and colder than "boredom" and the like can
influence. What you are dredging up does not actually exist.


On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>> Anyway, features aren't really allowed to break backward compatibility;
>> we've effectively got 10-year lifetimes for userspace-visible interfaces.
>> If this isn't good enough, well, tough.

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> All in all, I agree with you. The small differences lie in /proc files or
> oops syntax, etc... But even old syscalls are still supported and that's fine.
> I appreciate it when I read the packet(7) man page to find that even the
> interface from linux 2.0 is still supported.

Despite your appreciation the net effect is actually  irrelevance or
less.


On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> The problem is that nowadays, the userspace-visible code is not only in
> userspace anymore, but also involves modules interfaces sometimes because
> some commercial apps rely on modules (firewalls, virtual machines, etc...),
> and their userspace is nuts without those modules, so in a certain way,
> breaking some kernel internals within a stable release does break some apps.

On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
>> Either this is some kind of sick joke or you've never heard of SLES9.

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> the later :-)

SLES9 is a 2.6.x-based distro release from SuSE. It is in widespread
use by customers and customers are migrating to it en masse on account
of its 2.6.x basis due to 2.6.x'  superior performance and stability
characteristics. No "glowing praise" is necessary. This story tells itself.


On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
> (...) 
>> You have ignored my entire argument in favor of reiterating your own.
>> One more time, since this apparently needs to be repeated in a
>> condensed and/or simplified form.

On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
>> (1) the "stable" kernels are actually buggier because no one's looking

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> I don't agree with you. "known" bugs become features of this particular
> release and people learn how to play with them. The MM beahaviour when one
> single user can crash the whole machine just accidentely playing with malloc()
> would be called a bug on any other decent OS. For us it's a feature we have
> been used to live with.

Patterns of userspace usage that take down boxen are not "features" and
are never going to be considered valid aspects of "stable" releases.


On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> It's possible that 2.6 has fewer of those known bugs, but it still has many
> yet-to-discover bugs (the first ones being all those 'my machine does not
> boot anymore' reported here and caused by those too long release cycles).

Ockham. QED.


On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>> (2) the creation of those feature patches for stable kernels has
>> 	detracted from the efforts needed to get them actually into
>> 	the kernel, and they're not going to exist for long

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> I agree with you on the first part, but not on the second one, because
> as a stable kernel implies it, it will still be possible to apply
> current patches to new releases with very few efforts. Indeed, I have
> already sent rediffed > patches to different maintainers because they
> were easy to do. For a while now, on 2.4, you can easily apply
> jiffies64, epoll, netdev-random, preempt, lowlat, bme, squashfs, tux,
> etc... The list is long and demonstrantes what stable code looks like.
> "stable" does not mean it will not crash, but it means "it will not
> change much", eventhough this tends to imply the former.


Now the everrever-changing definition of "stable" comes into play.
If you can't handle the baseline changing, freeze on a specific release.


On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
>> People are already using it to run the databases their paychecks rely on.

On Mon, Jan 03, 2005 at 10:38:45PM +0100, Willy Tarreau wrote:
> I feel they're brave. I know several other people who went back,
> either because they didn't feel comfortable with upgrades these size,
> which sometimes did not boot because of random patches, or simply
> because of the scheduler which didn't let them type normally in an
> SSH session on a CPU-bound system, or even a proxy which performance
> dropped by a factor of 5 between 2.4 and 2.6. I know they don't
> report it, but they are not developpers. They see that 2.6 is not
> ready yet, and turn back to stable 2.4.

They are not brave. They are the most cowardly people in existence.
They don't dare go on using 2.4.x because it can't handle the load,
because it can't hadle the bigger and newer machines, and because it
just doesn't work for them. It's not like they moved frivolously;
they're more terrified of migrating than even the most horrible bugs.


-- wli
