Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbUCCWfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUCCWf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:35:29 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:37846 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261217AbUCCWfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:35:24 -0500
Date: Wed, 3 Mar 2004 23:35:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk
Cc: paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303223510.GE222@elf.ucw.cz>
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303222712.GA16874@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 03-03-04 22:27:12, Dave Jones wrote:
> On Wed, Mar 03, 2004 at 10:54:36PM +0100, Pavel Machek wrote:
>  > Hi!
>  > 
>  > Lots of machines have broken PST tables, so current in-kernel driver
>  > refuses to works on them. Vendors do get ACPI tables right because
>  > apparently Windows use them ;-). So this driver tends to work.
>  > 
>  > Comments? Could we get this into mainline?
> 
> I really dislike the idea of having >1 driver for this.
> Why can't we have a "use_acpi" module_param to switch to this ?

Well, that would probably not even link on kernel without ACPI...

We could make that functionality depend on CONFIG_ACPI, and allow
runtime selection only if its defined... But those two drivers are
pretty different just now and acpi-dependend chunk is pretty big. (It
does funny stuff like polling for AC plug removal if we are in
high-power state  and battery would not handle that. Old driver simply
refused to use high-power states on such machines.)

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
