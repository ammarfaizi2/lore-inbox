Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVDPBVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVDPBVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVDPBVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:21:15 -0400
Received: from fmr20.intel.com ([134.134.136.19]:8392 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262545AbVDPBVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:21:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16992.26700.512551.833614@sodium.jf.intel.com>
Date: Fri, 15 Apr 2005 18:20:12 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>, Bill Huey <bhuey@lnxw.com>,
       dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
In-Reply-To: <1113614062.4294.102.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	<1113352069.6388.39.camel@dhcp153.mvista.com>
	<1113407200.4294.25.camel@localhost.localdomain>
	<20050415225137.GA23222@nietzsche.lynx.com>
	<16992.20513.551920.826472@sodium.jf.intel.com>
	<1113614062.4294.102.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Steven Rostedt <rostedt@goodmis.org> writes:
>> On Fri, 2005-04-15 at 16:37 -0700, Inaky Perez-Gonzalez wrote:

> I have to agree with Inaky too.  Fundamentally, PI is the same for
> the system regardless of if the locks are user or kernel. I still
> don't see the difference here.  But for other reasons, I feel that
> the user lock should be a different structure from the kernel
> lock. That's why I mentioned that it would be a good idea if Ingo
> modulized the PI portion.  So that part would be the same for
> both. If he doesn't have the time to do it, I'll do it :-) (Ingo,
> all you need to do is ask.)

Can you qualify "different" here? I don't mean that they need to be
interchangeable, but that they are esentially the same. Obviously the
user cannot acces the kernel locks, but kernel locks are *used* to
implement user space locks.

Back to my example before: in fusyn, a user space lock is a kernel
space lock with a wrapper, that provides all that is necessary for
doing the fast path and handling user-space specific issues.

>> As long as the concept of rwlock allows for it to have multiple
>> owners (read locks need to have them), the procedure is mostly the
>> same. However, this not being POSIX, nobody (yet) has asked for it.
>
> I don't think rwlocks work well with PI.  You can implement it, but
> it's like implementing multiple inheritance for Object Oriented
> languages...

I have to agree--that's why I don't go further than saying in theory
is possible. I would only touch it with a ten foot pole or if someone
offered a lot in exchange :]

-- 

Inaky

