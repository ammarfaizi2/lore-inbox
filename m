Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSAYSbw>; Fri, 25 Jan 2002 13:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290770AbSAYSbg>; Fri, 25 Jan 2002 13:31:36 -0500
Received: from air-1.osdl.org ([65.201.151.5]:41105 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290766AbSAYSbU>;
	Fri, 25 Jan 2002 13:31:20 -0500
Date: Fri, 25 Jan 2002 10:31:43 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Grover, Andrew" <andrew.grover@intel.com>, "'lwn@lwn.net'" <lwn@lwn.net>,
        "Acpi-linux (E-mail)" <acpi-devel@lists.sourceforge.net>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: ACPI mentioned on lwn.net/kernel
In-Reply-To: <E16UAZO-00034f-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201251019230.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, Alan Cox wrote:

> > battery status, the steps the OS must perform are defined by the BIOS.
> > However, since they are performed by the OS, the OS in fact gains visibility
> > into the process, and does not ever relinquish control to the BIOS.
> 
> It has task file IDE access. It is capable of being abused for that or more.
> Intent doesnt come into it. Its no different to the current BIOS SMM
> situation. 

That's not his point. ACPI is doing what the BIOS tells us, not asking the 
BIOS to do something for is. That's not a Good Thing, but it's Better. 

Unless you're proactive about scanning BIOS routines for power mgmt,
verifying tables, and analyzing AML before you use it, you won't know 
something is wacky until it bites you. 

With AML, at least you have the freedom to pinpoint the problem and 
overridde it, either by modifying the table yourself, or providing a new 
one(*).

I'm a big ACPI pundit, and disagree with many aspects of the spec and 
implementation. But, a) we're stuck with it and b) it's a lot better in 
many aspects than previous things, including the ability to catch and work 
around problems rather than just punting on them.

	-pat

(*) Aside from any potential copyright infringement on the tables 
themselves. But, it is theoretically possible to override the DSDT with 
one provided at runtime. So, if someone finds a problem with Company X, 
Model Y's AML, they can go to acpi.sf.net and download a fixed table, run 
a utility to put it in the early init scripts, reboot and be safe. 
Hypothetically. 



