Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVAHRXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVAHRXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVAHRWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:22:38 -0500
Received: from orb.pobox.com ([207.8.226.5]:8155 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261220AbVAHRW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:22:29 -0500
Date: Sat, 8 Jan 2005 09:22:21 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Message-ID: <20050108172221.GA4306@ip68-4-98-123.oc.oc.cox.net>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501081049.02862.rjw@sisk.pl> <20050108131909.GA7363@elf.ucw.cz> <200501081610.57625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501081610.57625.rjw@sisk.pl>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 04:10:57PM +0100, Rafael J. Wysocki wrote:
> If I comment out only the modification of jiffies in timer_resume() in 
> arch/x86_64/kernel/time.c (ie line 986), everything seems to work, but I get 
> "APIC error on CPU0: 00(00)" after device_power_up(), which seems strange to 
> me, because I boot with "noapic".  On the other hand, if it's not commented 

Actually, I saw this APIC error too (on i386, with "noapic"), but I
ignored it because, aside from that message, all of my interrupt
problems were gone and I had fully working swsusp for the first time in
recorded history.

I should see what happens if I recompile with APIC support. Hopefully
I'll be able to get to that today.

-Barry K. Nathan <barryn@pobox.com>

