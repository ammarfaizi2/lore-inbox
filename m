Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSFJHAu>; Mon, 10 Jun 2002 03:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316705AbSFJHAt>; Mon, 10 Jun 2002 03:00:49 -0400
Received: from [202.135.142.196] ([202.135.142.196]:29193 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316695AbSFJHAt>; Mon, 10 Jun 2002 03:00:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, ralf@gnu.org, rhw@memalpha.cx,
        mingo@redhat.com, paulus@samba.org, anton@samba.org,
        schwidefsky@de.ibm.com, bh@sgi.com, davem@redhat.com, ak@suse.de,
        torvalds@transmeta.com
Subject: Re: Hotplug CPU Boot Changes: BEWARE 
In-Reply-To: Your message of "07 Jun 2002 08:51:32 CST."
             <m1elfjw39n.fsf@frodo.biederman.org> 
Date: Mon, 10 Jun 2002 17:05:16 +1000
Message-Id: <E17HJEs-00061l-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <m1elfjw39n.fsf@frodo.biederman.org> you write:
> But for the latter something just a little more than minimal hacks
> must be implemented.  But dynamic cpu enable/disable is definitely
> worth it.

Perhaps I didn't make myself clear: hotplugging does not neccessarily
mean physically removing or adding the CPU.  And as to whether they
offer full support, or stub support, architectures can decide that for
themselves, as they need.  It's not my call.

I don't know how much of a win it is to disable HT on cpus, but I can
tell you that adding & subtracting CPUs is a fairly heavy-weight
operation in this design (I don't think we really want to lock around
every cpu iteration).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
