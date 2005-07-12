Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVGLKdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVGLKdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVGLKdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:33:45 -0400
Received: from [203.171.93.254] ([203.171.93.254]:24992 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261329AbVGLKct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:32:49 -0400
Subject: Re: [PATCH] [3/48] Suspend2 2.1.9.8 for 2.6.12:
	301-proc-acpi-sleep-activate-hook.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DsHtr-0001ly-00@chiark.greenend.org.uk>
References: <11206164393426@foobar.com> <11206164393081@foobar.com>
	 <20050710230347.GB513@infradead.org> <20050710230347.GB513@infradead.org>
	 <1121150703.13869.27.camel@localhost>
	 <E1DsHMp-00062f-00@chiark.greenend.org.uk>
	 <E1DsHMp-00062f-00@chiark.greenend.org.uk>
	 <1121162866.13869.142.camel@localhost>
	 <E1DsHtr-0001ly-00@chiark.greenend.org.uk>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121164472.13869.156.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 20:34:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 20:22, Matthew Garrett wrote:
> Nigel Cunningham <ncunningham@cyclades.com> wrote:
> > On Tue, 2005-07-12 at 19:47, Matthew Garrett wrote:
> >> In general, the kernel does very little to prevent users from shooting
> >> themselves in the foot (or even chainsawing off their arms). We can do
> >> these checks in userspace rather than adding more kernel code.
> > 
> > Just because the kernel does very little, that doesn't mean it should.
> > Particularly for something like suspend to disk, where it's not just a
> > matter of an oops but of potential hard disk corruption, this is
> > important.
> 
> The kernel isn't there to protect people. It's there to provide
> functionality.

Both are true. If it only provided functionality, it wouldn't remount
filesystems read only on journal errors or the like.
 
> > If I could do it in userspace, I would. The trouble is, the userspace
> > app may not be there to tell the user what is happening, and this might
> > be part of the problem.
> 
> You're suggesting that users who are technically competent to compile
> their own kernel and write their own initrd scripts are unable to deal
> with checking whether or not a filesystem is mounted? You don't need an
> application to do that, it's a simple matter of shell scripting. And, in
> almost every case, if something is a simple matter of shell scripting it
> shouldn't be in the kernel.

I'm suggesting that people make mistakes, and they don't always read the
documentation or think of everything. These checks are there precisely
because people have messed up in the past, and to cover the case where
userspace isn't ready or able - for whatever reason - to do those checks
or tell the user they've done something wrong.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

