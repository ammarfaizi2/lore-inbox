Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312335AbSCYHxs>; Mon, 25 Mar 2002 02:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312337AbSCYHxj>; Mon, 25 Mar 2002 02:53:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35384 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312335AbSCYHxa>; Mon, 25 Mar 2002 02:53:30 -0500
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nice values for kernel modules
In-Reply-To: <Pine.LNX.4.33.0203161300300.1089-100000@einstein.homenet.suse.lists.linux.kernel>
	<E16mICa-0006mr-00@the-village.bc.nu.suse.lists.linux.kernel>
	<p73d6y4187b.fsf@oldwotan.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Mar 2002 00:47:27 -0700
Message-ID: <m1pu1tum0g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > Ability to bypass the stupid commercial time-locked licences (at some time
> > > wordperfect demo was locked like that and my timetravel module turned a
> > > demo into full product -- users were happy, at least according to emails I
> > > received :)
> > 
> > Not any more. Under the DMCA your time travel module probably makes you
> > a fugtive from US justice 8)
> > 
> > In general though calling into the syscall table by hand is a bad move. If
> > the function you are calling is generically useful then its much better to
> > work out whether the real function should be exported.
> 
> Some programs depends on tapping the system call table. For example private
> ice and oprofile do this for execve and other calls to know when a new 
> process is started. It would be possible to add function pointers to all these
> functions, but just tapping the system call table actually looks cleaner
> to me. 
> 
> [yes, the approach has module unload races, but these modules tend to just 
> make themselves not unloadable]

What is wrong with using ptrace?  That should already give you a hook into
every syscall.

Eric

