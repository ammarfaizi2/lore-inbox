Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWJHWm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWJHWm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWJHWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:42:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18912 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932071AbWJHWm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:42:27 -0400
Date: Sun, 8 Oct 2006 15:42:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Duran, Leo" <leo.duran@amd.com>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Jeff Garzik <jeff@garzik.org>, Andi Kleen <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: RE: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <1449F58C868D8D4E9C72945771150BDF46F9B5@SAUSEXMB1.amd.com>
Message-ID: <Pine.LNX.4.64.0610081539010.3952@g5.osdl.org>
References: <1449F58C868D8D4E9C72945771150BDF46F9B5@SAUSEXMB1.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Oct 2006, Duran, Leo wrote:
> 
> But, allow me to cite another example to reinforce my point about the
> merit of ACPI: Staying with processor power management interfaces, how
> about 'dynamic' interfaces such as _PPC? _PPC describes to the OS the
> platform's desired behavior based on some event, like unplugging the
> power-cord on a laptop - I find merit on that kind of platform-to-OS
> communication mechanism (I don't like the idea of having the platform
> making decisions & taking actions behind the OS's back... and even if it
> had to, I like the idea of at least providing some kind of notification,
> which is possible via ACPI interfaces).

The thing is, we'd just have been much better off if Intel had just 
specified some perfectly regular interrupt for a "power management event", 
coming out of a PCI device for that thing (say, the southbridge?), and 
just tried to standardize it.

We'd have far fewer bugs that way. As it is, we need to often know about 
how the hardware works _anyway_, just to fix up the problems that not 
knowing about it causes.

			Linus
