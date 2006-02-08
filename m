Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWBHECc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWBHECc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbWBHECc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:02:32 -0500
Received: from thunk.org ([69.25.196.29]:24200 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965193AbWBHECb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:02:31 -0500
Date: Tue, 7 Feb 2006 23:02:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
Message-ID: <20060208040220.GC7394@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Chow <davidchow@shaolinmicro.com>,
	linux-kernel@vger.kernel.org
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com> <20060207221513.GA7394@thunk.org> <43E940BF.7020203@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E940BF.7020203@shaolinmicro.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 08:52:15AM +0800, David Chow wrote:
> I have no expectation the LKML will agree to my point . Because 99% of 
> the LKML are likely technical users and community developers. As said, 
> they only care about programming drivers in the kernel source. Freedom 
> of change is cool and fun for them.

Actually, most of the developers work for some a distributions or a
system vendor.  I for example happen to work for IBM's Linux
Technology Center.  In that role, I do worry about the device drivers
for the hardware devices that we sell to our customers.  However, I
also am a community developer, and with that hat on I care about Linux
being the best OS it can be technically.  

I will say that my experience has been that binary kernel modules can
easily turn into a disaster for our customers.  It's a major issue
when a customer needs to install an errata kernel issued by one of our
Linux Distribution Partners for stability or security reasons, and
they are using a propietary binary kernel module from some third party
storage vendor which hasn't yet updated their proprietary binary
driver for that errata kernel.

Or there was the time that positively warmed my heart when I spent
several very late nights trying to debug a situation for a very high
profile, important customer trying to use a Samba file server running
on IBM hardware being integrated by IBM Global Services, and the
system kept on falling over.  It turned out the problem was caused by
a memory leak in a propietary, binary-only kernel module from an
commercial anti-virus product that shall remain nameless.   

So I am firm believer in giving our customers access to source code to
all kernel code, not because of any deep desire to "programming
drivers in kernel source", or because of any "information wants to be
free" religion --- but because it's the best way to keep our
customer's systems running reliably and nearly problem-free --- and
when there is a problem, I know that we have whatever is necessary to
make their problem Go Away.

Yes, I'm aware of the traditional arguments that a stable device
driver API would solve all of these problems.  Well.... at least the
first problem; incompetently written propietary kernel modules filled
with memory leaks and wild pointer dereferences and race conditions
aren't solved by standardized driver API's; the only solution is
source access so we can fix the idiotically written modules.  But the
reality is the way the Linux kernel is developed, a stable driver API
would never work.

						- Ted

P.S.  Obligatory disclaimer: These are my own opinions, and not
necessarily those of my employer.
