Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162038AbWKOXDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162038AbWKOXDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031028AbWKOXDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:03:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56776 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1031022AbWKOXDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:03:23 -0500
Date: Thu, 16 Nov 2006 00:03:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       ebiederm@xmission.com, hpa@zytor.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, magnus.damm@gmail.com,
       ak@suse.de, rjw@sisk.pl
Subject: Re: [Fastboot] [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061115230305.GA4339@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061115212411.GF9039@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115212411.GF9039@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I don't have a configuration I can test this but it compiles cleanly
> > and it should work, the code is very similar to the SMP trampoline,
> > which I have tested.  At least now the comments about still running in
> > low memory are actually correct.
> > 
> > Vivek has tested this patch for suspend to memory and it works fine.
> > 
> 
> More update. Got hold of another machine and suspend/resume seems to be
> facing problems.
> 
> With 2.6.19-rc5-git2
> --------------------
> - echo 3 > /proc/acpi/sleep (Suspend to memory takes place)
> - Press power button (System tries to come back but fails in MPT adapter
> 			initialization)
> 
> With 2.6.19-rc5-git2 + Reloc patches
> ------------------------------------
> - echo 3 > /proc/acpi/sleep (Suspend to memory takes place)
> - Press power button (Fan powers on but nothing additional is displayed on
> 			serial console.)
> 
> Will do a bisect and try to isolate the problem.
> 
> Pavel, I hope my testing procedure is right?

Yep, basically.

If you were end user, I'd tell you to use s2ram from suspend.sf.net to
get video. But you have serial console, so you don't need VGA ;-).

I do not know what MPT is; SCSI adapter? Yep, I'd expect that to have
problems.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
