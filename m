Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262676AbSJOIQO>; Tue, 15 Oct 2002 04:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSJOIQO>; Tue, 15 Oct 2002 04:16:14 -0400
Received: from [195.39.17.254] ([195.39.17.254]:14340 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262676AbSJOIQN>;
	Tue, 15 Oct 2002 04:16:13 -0400
Date: Tue, 15 Oct 2002 10:20:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ralf Gerbig <rge@hsp-law.de>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 ACPI/Suspend with an Acer Travelmate 350
Message-ID: <20021015102049.C277@elf.ucw.cz>
References: <m0fzv8ohjm.fsf-news@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m0fzv8ohjm.fsf-news@hsp-law.de>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi Andrew, Pavel, lkml
> 
> I just poked around with /proc/acpi/sleep without much hope as I was
> never able to get this otherwise nice lapdog to sleep _and_ resume
> before. The swsusp patches on 2.4.1[89] worked exept the touchpad
> would not respond after the resume.
> 
> But wow, this time at least the kernel survived!
> 
> Most of the following is hand copied, beware the typos
> 
> echo 1 > /proc/acpi/sleep
> =pdflush: bogus wakeup!
> ==|

We should not need to stop processes (etc) on S1, etc.

> Same here:
> 
> echo 5 > /proc/acpi/sleep
> 
> Suspending devices
> Shutting down devices

Oopses on shutdown... We should not suspend devices here, either...

							Pavel
-- 
When do you have heart between your knees?
