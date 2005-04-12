Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVDLWKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVDLWKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVDLWGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:06:16 -0400
Received: from khc.piap.pl ([195.187.100.11]:3076 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262994AbVDLWEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:04:09 -0400
To: Sensei <senseiwa@tin.it>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
	<425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>
	<425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain>
	<425C03D6.2070107@tin.it>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 13 Apr 2005 00:04:06 +0200
In-Reply-To: <425C03D6.2070107@tin.it> (Franco's message of "Tue, 12 Apr
 2005 12:22:30 -0500")
Message-ID: <m37jj7hctl.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Franco \"Sensei\"" <senseiwa@tin.it> writes:

> What about making extensive use of modules? If everything (acceptable)
> is built on modules, can you still have abi, can you still change
> modules and api implementation without breaking anything?

Yes, but you still can't change .config. You enable SMP, your binary
compatibility is history. You _have_to_ be able to enable SMP and
_you_have_ to be able to disable it.

The following kernel packages are parts of Fedora Core 3:
kernel-2.6.9-1.667.i586.rpm
kernel-2.6.9-1.667.i686.rpm
kernel-smp-2.6.9-1.667.i586.rpm
kernel-smp-2.6.9-1.667.i686.rpm

4 of them, each with a different ABI. And this is all the same kernel
major-minor-version-subversion and the same compiler - only the settings
differ.

> I'm really curious about it. How abi can be made actual, and how would
> it be if we had a completely modular kernel (not micro, but something
> alike, modular in kernel-space, not in user-space).

Being modular has nothing to do with the "problem" (except it's probably
required, but Linux _is_ modular for some time now).

> Quite the same, yes. You can still have different kernels of course!

Not "can". You have to. You don't want the kernel running on your dual
Athlon MP to power your old Pentium MMX test machine. The modules are
irrelevant.

> By the way, another stupid curiosity is why /lib/modules instead of
> /boot?

You can have it in /boot. In fact, it's not a kernel issue.

> Because boot can be a partition and not be mounted?

Actually, because boot can be a small partition, and may lack support
for, say, long filenames.
Actually, I put the kernels in /lib/modules/* as well. I have no /boot
file systems and I like the idea of rm -rf /lib/modules/something
deleting all files related to a particular kernel.
-- 
Krzysztof Halasa
