Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317296AbSFGPBo>; Fri, 7 Jun 2002 11:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317297AbSFGPBn>; Fri, 7 Jun 2002 11:01:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51288 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317296AbSFGPBm>; Fri, 7 Jun 2002 11:01:42 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, ralf@gnu.org, rhw@memalpha.cx,
        mingo@redhat.com, paulus@samba.org, anton@samba.org,
        schwidefsky@de.ibm.com, bh@sgi.com, davem@redhat.com, ak@suse.de,
        torvalds@transmeta.com
Subject: Re: Hotplug CPU Boot Changes: BEWARE
In-Reply-To: <E17GHB3-0000gD-00@wagner.rustcorp.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2002 08:51:32 -0600
Message-ID: <m1elfjw39n.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> Hi all (esp port maintainers),
> 
> 	In writing the hotplug CPU stuff, Linus asked me to alter the
> boot sequence to "plug in" CPUs.  I am shortly going to be sending
> these patches to him now I have got my x86 box to boot with the
> changes.

If to the general SMP case is added the ability to dynamically enable
and disable cpus at runtime, this infrastructure work appears to have
general applicability now.  Allowing for example dynamic
enable/disable of HT on P4-Xeons at runtime for example.


> There are two ways to transition: one is to do the minimal hacks so
> that the new boot code works (as per my x86 patch).  The other is to
> take into account that the next stage (optional by arch) is to
> actually bring cpus up and down on the fly, and hence actually write
> code that will work after boot as well (as per my ppc patch).

Thinking in terms of physically hot-plugging cpus has me doubt the
actual utility of this code.  Instead thinking of dynamically enabling
and disabling processors for debugging sounds very reasonable.

But for the latter something just a little more than minimal hacks
must be implemented.  But dynamic cpu enable/disable is definitely
worth it.

Eric

