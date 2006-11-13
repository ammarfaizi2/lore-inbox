Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933132AbWKMXCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbWKMXCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933135AbWKMXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:02:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3750 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S933132AbWKMXCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:02:19 -0500
Date: Tue, 14 Nov 2006 00:01:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061113230156.GF1701@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <200611131822.44034.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131822.44034.ak@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - Killed lots of dead code
> > - Improve the cpu sanity checks to verify long mode
> >   is enabled when we wake up.
> > - Removed the need for modifying any existing kernel page table.
> > - Moved wakeup_level4_pgt into the wakeup routine so we can
> >   run the kernel above 4G.
> > - Increased the size of the wakeup routine to 8K.
> > - Renamed the variables to use the 64bit register names.
> > - Lots of misc cleanups to match trampoline.S
> > 
> > I don't have a configuration I can test this but it compiles cleanly
> > and it should work, the code is very similar to the SMP trampoline,
> > which I have tested.  At least now the comments about still running in
> > low memory are actually correct.
> > 
> > Vivek has tested this patch for suspend to memory and it works fine.
> 
> Suspend is unfortunately quite fragile.
> 
> pavel, rafael can you please test and review this patch? 

> (full patch is on l-k)

Based on comments, it looks like there'll be new version of patch,
anyway? Vivek, would you cc me?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
