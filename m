Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVATURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVATURW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVATURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:17:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54211 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261380AbVATURR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:17:17 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 0/29] overview
References: <20050120102223.B14297@almesberger.net>
	<m1vf9s3ozr.fsf@ebiederm.dsl.xmission.com>
	<20050120165150.A21510@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jan 2005 13:15:38 -0700
In-Reply-To: <20050120165150.A21510@almesberger.net>
Message-ID: <m1is5r502d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> So if there was a vote to be cast for getting kexec into mainline
> as quickly as possible, you'd certainly have mine :-)

The hard one there is support of arbitrary OS's.  Most
of the existing interfaces that have been designed require callbacks
during booting which is the hard piece to support in a linux based
environment.

But loadlin does fairly strongly show that you can do interesting
things to load a non-native OS if you have the appropriate
environment.

I think part of the challenge is the conversation on what should
happen with bootloaders is fragmented.  But that may not be
a bad thing.  Most people want to implement simple boot policies,
and really don't care for the full complexity that some firmware
solutions allow.  So what I have seen is people will take kexec
and implement their custom policy instead of doing something complex.

With 1MB ROMS starting to show up it using a kernel based bootloader
is starting to look like a real possibility on the LinuxBIOS front.

There is also the other use case that I have a use for as well.
Kernel upgrades.  I need to get my patch into /sbin/reboot or
at least the initscripts but the ability to easily switch from
one kernel to another without going through the firmware is also
very handy.  That case is the core case has been my motivating
factor lately.

And at this point the question is really not about getting
kexec into the mainline.  Andrew picking it up, the syscall number
being reserved, and interface being fixed have done that.  The goal
now is to build enough confidence so that we can move from the
development to the stable kernel.

Want to help?

Eric
