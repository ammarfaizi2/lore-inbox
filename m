Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTE1WuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTE1WuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:50:21 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61609 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261422AbTE1WuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:50:16 -0400
Date: Thu, 29 May 2003 01:03:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030528230318.GB2236@elf.ucw.cz>
References: <20030521152255.4aa32fba.akpm@digeo.com> <20030521152334.4b04c5c9.akpm@digeo.com> <20030526093717.GC642@zaurus.ucw.cz> <20030528144839.47efdc4f.akpm@digeo.com> <20030528215551.GB255@elf.ucw.cz> <20030528150610.3df70031.akpm@digeo.com> <20030528221812.GC255@elf.ucw.cz> <20030528154651.177488f3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528154651.177488f3.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yes, x86-64 and sparc64 were converted.
> 
> OK, I know who to bug about those.
> 
> > It is really #included, sorry
> > about that, but I found no other solution. Patch looks like:
> 
> > +#define INCLUDES
> > +#include "compat_ioctl.c"
> 
> hm, how does the preprocessor locate this file?  Does the build system set
> up a symlink?

I used to put relative path there, now I do:

--- /usr/src/tmp/linux/arch/x86_64/ia32/Makefile        2003-05-27
13:42:40.000000000 +0200
+++ /usr/src/linux/arch/x86_64/ia32/Makefile    2003-05-27
14:58:31.000000000 +0200
@@ -14,3 +14,4 @@
                -o $@ -Wl,-T,$^

 AFLAGS_vsyscall.o = -m32
+CFLAGS_ia32_ioctl.o += -Ifs/

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
