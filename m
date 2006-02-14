Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422787AbWBNUQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbWBNUQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWBNUQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:16:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:9354 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422784AbWBNUQs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:16:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Tue, 14 Feb 2006 21:17:30 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de>
In-Reply-To: <43F216FE.7050101@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602142117.31232.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 18:44, Thomas Renninger wrote:
> Pavel Machek wrote:
> > On Pá 10-02-06 09:06:43, Stefan Seyfried wrote:
> >> On Wed, Feb 08, 2006 at 12:57:53PM +0000, Matthew Garrett wrote:
> >>> The included patch adds support for power management methods to register 
> >>> callbacks in order to allow drivers to check if the system is on AC or 
> >>> not. Following patches add support to ACPI and APM. Feedback welcome.
> >> Ok. Maybe i am not seeing the point. But why do we need this in the kernel?
> >> Can't we handles this easily in userspace?
> > 
> > Some kernel parts need to now: for example powernow-k8: some
> > frequencies are not allowed when you are running off battery. [Just
> > now it is solved by not allowing those frequencies at all unless ACPI
> > is available; quite an ugly solution.]
> > 
> Allowed CPUfreqs are exported via _PPC.
> This is why a lot hardware sends an ac_adapter and a processor event
> when (un)plugging ac adapter.
> Limiting cpufreq already works nice that way.
> 
> AMD64 laptops are booting with lower freqs per default until they are
> pushed up, so there shouldn't be anything critical?

This is not true as far as my box is concerned (Asus L5D).  It starts with
the _highest_ clock available.

> For the brightness part, I don't see any "laptop is going to explode"
> issue.
> I always hated the brightness going down when I unplugged ac on M$

Currently I have the same problem on Linux, but I don't know the solution
(yet).  Any hints? :-)

Rafael
