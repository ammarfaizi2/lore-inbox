Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWI1X3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWI1X3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWI1X3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:29:30 -0400
Received: from xenotime.net ([66.160.160.81]:62624 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751115AbWI1X33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:29:29 -0400
Date: Thu, 28 Sep 2006 16:30:46 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       jbeulich@novell.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
Message-Id: <20060928163046.055b3ce0.rdunlap@xenotime.net>
In-Reply-To: <451C58AC.5060601@imap.cc>
References: <4516B966.3010909@imap.cc>
	<20060924145337.ae152efd.akpm@osdl.org>
	<451BFFA9.4030000@imap.cc>
	<200609281912.01858.ak@suse.de>
	<451C58AC.5060601@imap.cc>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 01:20:12 +0200 Tilman Schmidt wrote:

> Am 28.09.2006 19:12 schrieb Andi Kleen:
> > On Thursday 28 September 2006 19:00, Tilman Schmidt wrote:
> > 
> > missing context here, but ...
> 
> Forwarded by separate mail.
> 
> >> x86_64-mm-i386-stacktrace-unwinder.patch
> [...]
> >> Backing out just this patch from 2.6.18-mm1 (and resolving conflicts
> >> manually the obvious way) gets the boot time back to normal (ie. as
> >> fast as 2.6.18 mainline) on my
> >> Linux gx110 2.6.18-mm1-noinitrd #2 PREEMPT Thu Sep 28 18:48:32 CEST 2006 i686 i686 i386 GNU/Linux
> >> machine.
> > 
> > Hmm, i assume you have lockdep on.
> 
> Indeed.
> 
> > The new backtracer is of course slower
> > than the old one and it will slow down lockdep which takes a lot of backtraces. 
> > But it shouldn't be a significant slowdown.
> 
> Unfortunately, it is. Boot time roughly doubles from 39 to 76 secs.
> 
> > Can you perhaps boot with profile=1 and then send readprofile output after
> > boot?
> 
> I'm afraid I'll need instructions for that. I assume "profile=1"
> is to be appended to the kernel command line; but how do I
> retrieve that readprofile output you are asking for?

Use 'readprofile'.  Usage is described in
Documentation/basic_profiling.txt in the kernel source tree.

---
~Randy
