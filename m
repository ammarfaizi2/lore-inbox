Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTFIPvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbTFIPvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:51:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24408 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S264487AbTFIPvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:51:10 -0400
To: Warren Togami <warren@togami.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memtest86 on the opteron
References: <20030607202725.22992.qmail@email.com.suse.lists.linux.kernel>
	<20030607214356.GF667@elf.ucw.cz.suse.lists.linux.kernel>
	<1055040745.27939.3.camel@camp4.serpentine.com.suse.lists.linux.kernel>
	<p73of195bj1.fsf@oldwotan.suse.de> <1055054691.18692.13.camel@laptop>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jun 2003 10:04:16 -0600
In-Reply-To: <1055054691.18692.13.camel@laptop>
Message-ID: <m17k7v1blr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warren Togami <warren@togami.com> writes:

> On Sat, 2003-06-07 at 20:27, Andi Kleen wrote:
> > Bryan O'Sullivan <bos@serpentine.com> writes:
> > 
> > > On Sat, 2003-06-07 at 14:43, Pavel Machek wrote:
> > > 
> > > > Well, as opteron is i386-compatible, you should be able to simply use
> > > > i386 memtest...
> > > 
> > > It doesn't work.  Crashes and reboots the system shortly after it
> > > starts.  The serial console support appears to have bit-rotted, too, so
> > > I've not been able to capture an output screen to diagnose the problem.
> > 
> > The problem is the CPUID handling in memtest86. It does not expect
> > the 15 model number on AMD systems. Someone did a patch for it, but
> > I don't remember where they put it. Anyways should be easy to fix again
> > given the source.
> > 
> 
> If you find the patch I am interested in it.  Please CC me.
> 
> I am guessing that a normal 32bit compiled memtest86 wont be able to
> test beyond 4GB of RAM on AMD64?

memtest86 has PAE support so it should be able to test everything.
I have tested with 6GB of RAM on an old PIII.

Beyond the cpuid thing.  There is a bug in the probing of how much memory
is cached.  Last time I was playing with it I just disabled that section
of code.

If nothing else ping me a few times because I will need this shortly.
If it really does not work.  And I am familiar with the code so I will
certainly get it fixed.

Eric
