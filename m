Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVACMhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVACMhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVACMhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:37:23 -0500
Received: from holomorphy.com ([207.189.100.168]:32154 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261174AbVACMhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:37:06 -0500
Date: Mon, 3 Jan 2005 04:33:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103123325.GV29332@holomorphy.com>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103053304.GA7048@alpha.home.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
>> They're superseded by iptables and their sole uses are by the Linux-
>> specific applications to manipulate this privileged aspect of system
>> state. This makes a much weaker case for backward compatibility than
>> general nonprivileged standardized system calls.

On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> That's not the problem. There was a feature freeze by which
> everything which was considered hard to maintain or not very stable
> should have been removed. When 2.6 was announced, it was with a set
> of features. Who know, perhaps there are a few people who could
> replace a kernel 2.0 by a 2.6 on some firewalls. Even if they are
> only 2 or 3 people, there is no reason that suddenly a feature should
> be removed in the stable series. But it should be removed in 2.7 if
> it's a nightmare to maintain.

This is bizarre. iptables was made the de facto standard in 2.4.x and
the alternatives have issues with functionality. The 2.0/2.2 firewalling
interfaces are probably ready to go regardless. You do realize this is
what you're referring to?

2 major releases is long enough.


On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> If the motivation to break backwards compatibility is not enough
> anymore to justify development kernels, I don't know what will
> justify it anymore. I'm particularly fed up by some developer's
> attitude who seem to never go outside and see how their creations are
> used by people who really trust the "stable" term... until they
> realize that this word is used only for marketting,

Who do you think is actually banging out the code on this mailing list?

Anyway, features aren't really allowed to break backward compatibility;
we've effectively got 10-year lifetimes for userspace-visible interfaces.
If this isn't good enough, well, tough.


On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> eg. help distro makers announce their new major release at the right
> moment. ipfwadm had about 2 years to be removed before 2.6, wasn't
> that enough ? Once the stable release is out, the developer's point
> of view about how is creation *might* be used is not a justification
> to remove it. But of course, his difficulties at maintaining the code
> is fairly enough for him to say "well, it was a mistake to enable
> this, I don't want it in the future version anymore".

There isn't really any code behind ipfwadm, just a mocked-up interface.
I have little insight into what goes in in net/ to be honest. I do have
a firm notion that what goes on there is similar to the rest of the
kernel wrt. backward compatibility etc.


On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> Why do you think that so many people are still using 2.4 (and even
> older versions) ? This is because they are the only ones who don't
> constantly change under your feet and from which you can build
> something reliable and guaranteed maintainable. At least, I've not
> seen any commercial product based on 2.6 yet !
> Please, stop constantly changing the contents of the "stable" kernel.

Either this is some kind of sick joke or you've never heard of SLES9.


On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
>> The ``stable'' moniker and distros being based on 2.4 are horrors
>> beyond imagination and developers are pushed to in turn push
>> inappropriate features on 2.4.x and maintain them out-of-tree for
>> 2.4.x

On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> I clearly don't agree with you, for a simple reason : those out-of-tree
> features will always be, because each distro likes to add a few features,
> like SquashFS, PaX, etc... And indeed, that's one of the reasons I *stay*
> on 2.4. It's so simple to simply upgrade the kernel, patch and recompile
> without spending days complaining "grrr... why did they change this ?".
> As soon as you have at least *ONE* patch to apply to a kernel for your
> distro, 2.4 is a safer bet than 2.6 if you don't want to restart everything
> at each minor release. The 2.4 kernel is more what I consider stable than
> 2.6, eventhough it's not totally. 2.0 and 2.2 *are* stable, because I'm
> certain that every future releases will only be bugfixes and will touch
> only a few lines.

You have ignored my entire argument in favor of reiterating your own.

One more time, since this apparently needs to be repeated in a
condensed and/or simplified form.

(1) the "stable" kernels are actually buggier because no one's looking
(2) the creation of those feature patches for stable kernels has
	detracted from the efforts needed to get them actually into
	the kernel, and they're not going to exist for long


On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> At the moment, the only "serious" use I've found for a 2.6 is a kexec-based
> bootloader for known hardware. I've already seen that maintaining it up to
> date is not simple, I wonder how distro people work with it... I wouldn't
> have to do their work right now.

People are already using it to run the databases their paychecks rely on.
Whatever else you had in mind can't be anticipated.


-- wli
