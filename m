Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbTAKMCI>; Sat, 11 Jan 2003 07:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTAKMCI>; Sat, 11 Jan 2003 07:02:08 -0500
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:18048 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S267199AbTAKMCH>; Sat, 11 Jan 2003 07:02:07 -0500
Date: Sat, 11 Jan 2003 13:10:47 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Pavel Machek <pavel@ucw.cz>
cc: Marc Giger <gigerstyle@gmx.ch>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: ACPI power off requires swsusp (was: Re: Power off a SMP Box)
In-Reply-To: <20030106230058.GA372@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0301111301430.12267-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Pavel Machek wrote:

> > > You could try ACPI in (very) recent kernels.
> > 
> > You mean a 2.5.x kernel? Any Kernel with the newest ACPI patches has never powered off any of my machines:-(
> > Perhaps I don't know something...
> > I will try it now again...
> 
> You can also get new ACPI for 2.4.X (at acpi.sf.net) and even ACPI in
> marcelo's kernel should be good enough for poweroff.

I just disovered that in 2.5.56 (at least), ACPI power-off needs
CONFIG_ACPI_SLEEP which depends on CONFIG_SOFTWARE_SUSPEND.  This means
that without selecting software suspend, your machine cannot power off
using ACPI.  Why is it so?

/Tobias

