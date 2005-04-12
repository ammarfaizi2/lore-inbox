Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVDLLh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVDLLh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVDLLe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:34:58 -0400
Received: from khc.piap.pl ([195.187.100.11]:1540 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262270AbVDLL2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:28:41 -0400
To: Sensei <senseiwa@tin.it>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de>
	<425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de>
	<425B3864.8050401@tin.it>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 12 Apr 2005 13:28:34 +0200
In-Reply-To: <425B3864.8050401@tin.it> (Franco's message of "Mon, 11 Apr
 2005 21:54:28 -0500")
Message-ID: <m3mzs4kzdp.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Franco \"Sensei\"" <senseiwa@tin.it> writes:

> Major kernel changes should probably result in major version
> change... I'm supposing it. Of course, note that ABI can be achieved
> stating that all the binaries must be compiled with the same gcc.

It isn't enough. The same compiler and the same .config - yes. But that
means you'd have no progress within, say, 2.6. Only bug fixes.
There _is_ a tree like that - 2.6.11.Xs are only bugfixes.

But remember that changing a single config option may make your kernel
incompatible. You can't avoid that without making the kernel suboptimal
for most situations - basically you'd have to disable non-SMP builds,
disable (or permanently enable) 4KB pages etc.

If you make a proprietary closed-sourse system (with kernel modules), you
probably have to make the system suboptimal. But with open source there
is a better alternative.

> So,
> the kernel module library could possibly be simply /lib/modules/2.6/.

Asking for one modules dir only is similar to asking for only one
/boot/vmlinuz-2.6 kernel file.

> I'm probably (surely) not getting the point about this issue. It's not
> that bad... I don't see awkward issues in guaranteeing 2.6, 2.8 and so
> on compatibility with the ``major second number''.

First, each 2.6.X would have to be binary-compatible with itself.
-- 
Krzysztof Halasa
