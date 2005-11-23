Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVKWQKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVKWQKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKWQKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:10:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48546 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751204AbVKWQKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:10:30 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <p7364qjjhqx.fsf@verdi.suse.de>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	 <4374FB89.6000304@vmware.com>
	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	 <20051113074241.GA29796@redhat.com>
	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>
	 <438359D7.7090308@suse.de>  <p7364qjjhqx.fsf@verdi.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 16:42:13 +0000
Message-Id: <1132764133.7268.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 12:17 -0700, Andi Kleen wrote:
> > +	/* Paranoia */
> > +	asm volatile ("jmp 1f\n1:");
> > +	mb();
> 
> That would be totally obsolete 386 era paranoia. If anything then use 
> a CLFLUSH (but not available on all x86s) 

If you are patching code another x86 CPU is running you must halt the
other processors and ensure it executes a serialzing instruction before
it enters any patched code. 

How many kilobytes of tables do you add to the kernel to do this
pointless stunt btw ?

Alan "CPU errata are fun" Cox

