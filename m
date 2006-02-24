Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWBXXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWBXXor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWBXXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:44:47 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27818 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964800AbWBXXoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:44:46 -0500
To: Greg KH <gregkh@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
References: <20060221162104.6b8c35b1.akpm@osdl.org>
	<Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	<Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	<20060222112158.GB26268@thunk.org>
	<20060222154820.GJ16648@ca-server1.us.oracle.com>
	<20060222162533.GA30316@thunk.org>
	<20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	<20060222185923.GL16648@ca-server1.us.oracle.com>
	<20060222191832.GA14638@suse.de>
	<1140636588.2979.66.camel@laptopd505.fenrus.org>
	<20060222194024.GA15703@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 16:42:26 -0700
In-Reply-To: <20060222194024.GA15703@suse.de> (Greg KH's message of "Wed, 22
 Feb 2006 11:40:24 -0800")
Message-ID: <m1k6bk2ujh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> On Wed, Feb 22, 2006 at 08:29:48PM +0100, Arjan van de Ven wrote:
>> On Wed, 2006-02-22 at 11:18 -0800, Greg KH wrote:
>> > What about trying a stock 2.6.6 or so kernel?  Does that work
>> > differently from 2.6.15?
>> 
>> ... however it's very much designed only for the kernel that comes with
>> it (with "it's" I mean all the userspace infrastructure); all the
>> changes and additions since 2.6.9 aren't incorporated so you probably
>> really want new alsa, new initscripts, new mkinitrd, new
>> module-init-tools. some because of abi changes since 2.6.9, others
>> because the kernel grew capabilities that are really needed for "nice"
>> behavior.

Not being able to take advantage of the latest whizz bang features
sound sane.  Kernel ABI changes do not sound sane.

> I totally agree.  Distros are changing into two different groups these
> days:
> 	- everything tied together and intregrated nicely for a specific
> 	  kernel version, userspace tool versions, etc.
> 	- flexible and works with multiple kernel versions, different
> 	  userspace tools, etc.
>
> And this is a natural progression as people try to provide a more
> complete "solution" for users.

Huh? I can understand it from the rational of a support contract, 
limiting the number of possibilities you have to deal with.  Beyond
that it just seems ludicrous.  If something is relied up by user
space it should be stable enough that you can upgrade your kernel.

It should be a case of not-supported but it ``should'' work.  So
anyone who is competent enough to do kernel development should 
have no problem getting things going.

> When people to complain that they can't run a "kernel-of-the-day" on
> their "enterprise" distro, they are not realizing that that distro was
> just not developed to support that kind of thing at all.

Which is a really bad tack to take.  It seriously forks the kernel
debugging and testing efforts.  Even with a distro that only wants
to support one kernel if people are having kernel hardware interaction
problems I will still suggest that they upgrade their kernel to
see if the problems are fixed in the newer kernels.  If there are
user space glitches but the drivers work, there are a lot more people
who can fix user space than can fix the kernel.

The historic rule is that if you need to know what needs to be changed
you read through Documentation/Changes.  If your distro has something
older you probably need to upgrade if not you don't.

> So, in short, if you are going to do kernel development, pick a distro
> that handles different kernel versions.  Likewise, if you are doing
> userspace development (X.org, HAL, KDE, Gnome, etc.) you pick a distro
> that allows you to change that level of the stack.

But this applies to kernel debugging so having a distro that is tied
intimately to their kernel is a problem for anyone running on recent
hardware.

Eric
