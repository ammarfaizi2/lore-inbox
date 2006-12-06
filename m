Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758637AbWLFAWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637AbWLFAWl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758543AbWLFAWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:22:41 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2107 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637AbWLFAWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:22:40 -0500
Date: Wed, 6 Dec 2006 00:22:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       linux-arm-toolchain@lists.arm.linux.org.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
Subject: Re: More ARM binutils fuckage
Message-ID: <20061206002226.GK24038@flint.arm.linux.org.uk>
Mail-Followup-To: "Michael K. Edwards" <medwards.linux@gmail.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	linux-arm-toolchain@lists.arm.linux.org.uk,
	linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
References: <20061205193357.GF24038@flint.arm.linux.org.uk> <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 03:29:22PM -0800, Michael K. Edwards wrote:
> On 12/5/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >There's not much to say about this, other than scream and go hide in the
> >corner.  ARM toolchains are just basically fscked.
> 
> And while we're on the topic of ARM linux toolchain fsckage, it would
> be nice to know what patches and incantations are currently
> recommended when configuring gcc for building various modern ARM
> kernel/ABI configurations (OABI + soft VFP, EABI, etc.).

There is no such thing as soft VFP.

I can only talk from the requirements of the kernel.  gcc 3.4.3 is
the minimum for ARM, which with binutils 2.17 will allow you to build
the kernel as OABI in *any* configuration.  No patches required for
either.

Enabling EABI needs a compiler which supports EABI.  That's where I
get fuzzy but recent gcc 4 should be suitable.  I have had it suggested
to me that EABI support in the toolchain isn't all that stable at the
moment.

As for userspace... and NPTL, that's a different matter.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
