Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUANAFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUANAFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:05:18 -0500
Received: from smtp-out1.iol.cz ([194.228.2.86]:64387 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S266283AbUANAFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:05:12 -0500
Date: Wed, 14 Jan 2004 01:03:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: paul.devriendt@amd.com
Cc: davej@redhat.com, pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
       linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114000352.GB25158@elf.ucw.cz>
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a totally new driver, that I am hoping to release within about
> a month. (I did target the end of the year, but I got distracted on
> some other stuff). The new driver :
>   - uses ACPI to figure out the available p-states. I have seen a *lot*
>     of buggy BIOSs where the PSB/PST info is wrong or missing,
>   - uses ACPI to handle battery / mains power transitions,
> and some other clean ups.
> 
> I would appreciate some advice on a question ... should I leave the old
> non-ACPI capability there for those people who do not want to enable ACPI
> in the kernel ? If so, is this a big ifdef, or is there a better way to do
> it ? Or should I just say that it is dependent on ACPI, got to have
> ACPI ?

I have strange notebook here, and that one only works reasonably with
APM (with ACPI: no network IRQs, random mouse problems, random
shutdowns due to bad temperature readings).

I'd suggest to leave old driver there (possibly let me clean it up
;-)))), and create new powernow-k8-acpi, or powernow-acpi or something
like that.
								Pavel
-- 
When do you have heart between your knees?
