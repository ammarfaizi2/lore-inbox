Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266607AbSKGWTV>; Thu, 7 Nov 2002 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSKGWTV>; Thu, 7 Nov 2002 17:19:21 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:46329 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266607AbSKGWTU>; Thu, 7 Nov 2002 17:19:20 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com> 
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4C9@orsmsx119.jf.intel.com> 
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       benh@kernel.crashing.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 22:25:53 +0000
Message-ID: <3205.1036707953@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrew.grover@intel.com said:
>  Yes, ACPI can and should use standard kernel interfaces when they are
> available.

I'd go further than that. Where it's blatantly obvious that a standard 
kernel interface is going to be required for some functionality for which 
ACPI is the first implementation, that generic interface should have been 
implemented from the start.

> The interfaces you're talking about don't exist yet, but
> could be added.

Actually I do have boxes on which I "echo 1 > /proc/sys/pm/suspend" to make 
them sleep. Pavel's right though -- that's not a particularly wonderful 
interface either. Using sys_reboot() makes some sense to me.

But stuff like battery info in /proc/acpi just has no excuse.

--
dwmw2


