Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSKHVbJ>; Fri, 8 Nov 2002 16:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSKHVbI>; Fri, 8 Nov 2002 16:31:08 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12292 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262449AbSKHVbH>;
	Fri, 8 Nov 2002 16:31:07 -0500
Date: Tue, 15 Jan 2002 14:34:02 -0500
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, mingo@redhat.com,
       mochel@osdl.org
Subject: Re: [PATCH] Hotplug CPUs for i386 2.5.44
Message-ID: <20020115193356.GE2015@zaurus>
References: <20021028080437.DE7112C0E3@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021028080437.DE7112C0E3@lists.samba.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Usage:
> 1) Apply patch, and boot resulting kernel.
> 2) echo 0 > /devices/root/sys/cpu0/online
> 3) echo 1 > /devices/root/sys/cpu0/online
> 
> The CPU actually spins with interrupts off, doing cpu_relax() and
> polling a variable.  It's basically useful for testing the unplug
> infrastructure and benchmarking.

Hehe, with this swsusp should be doable on
an smp machine (turn it into UP and suspend;
during resume, turn it into UP, resume, and go
back SMP). I guess I schould get some SMP
to play with...
			Pavel
