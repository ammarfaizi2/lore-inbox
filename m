Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTGRI6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271264AbTGRI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 04:58:21 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:61895 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270727AbTGRI6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 04:58:20 -0400
Date: Fri, 18 Jul 2003 11:12:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@transmeta.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make CONFIG_ACPI_SLEEP independend on CONFIG_SOFTWARE_SUSPEND
Message-ID: <20030718091252.GA280@elf.ucw.cz>
References: <20030717211258.GA10221@elf.ucw.cz> <Pine.LNX.4.33.0307171959270.876-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0307171959270.876-200000@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This separates CONFIG_ACPI_SLEEP and CONFIG_SOFTWARE_SUSPEND. That
> > should end the user confusion. It also updates obsolete docs, and
> > makes code less noisy. Please apply,
> 
> Alright, I applied the initial patch to make those config options 
> independent, though with a slightly different take on it. 
> 
> I moved kernel/suspend.c to drivers/power/swsusp.c and extracted the 
> process suspension code to drivers/power/process.c. This removes the 
> #ifdef from swsusp.c. (drivers/power/process.c is compiled when CONFIG_PM 
> is set and drivers/power/swsusp.c only when CONFIG_SOFTWARE_SUSPEND is 
> set). 

I do not really like the placement; process suspension is not really a
device driver. What about kernel/power/*.c, instead?

Otherwise it looks good.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
