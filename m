Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWBGNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWBGNh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWBGNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:37:27 -0500
Received: from tim.rpsys.net ([194.106.48.114]:14022 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965073AbWBGNh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:37:26 -0500
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
From: Richard Purdie <rpurdie@rpsys.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207132334.GA2331@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org>
	 <20060206191916.GB17460@srcf.ucam.org>
	 <20060207003748.GA22510@srcf.ucam.org>
	 <200602062237.55653.dtor_core@ameritech.net>
	 <20060207123204.GA1423@srcf.ucam.org>
	 <1139317605.6422.26.camel@localhost.localdomain>
	 <20060207132334.GA2331@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 13:37:06 +0000
Message-Id: <1139319426.6422.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 13:23 +0000, Matthew Garrett wrote:
> On Tue, Feb 07, 2006 at 01:06:45PM +0000, Richard Purdie wrote:
> 
> > This is total abuse of the backlight class. The idea is that
> > cat /sys/class/backlight/ccc/brightness returns the *current* backlight
> > brightness. On AC power it should return the AC brightness value and on
> > DC power return the DC value.
> 
> Unfortunately, the hardware doesn't seem to give us that option. There's 
> no obvious way of determining whether we're on AC or DC from the kernel 
> without doing very nasty things with ACPI and APM (userspace can work it 
> out fairly easily).
>
> Would you be open to adding generic support for displaying separate AC 
> and DC brightnesses? Making it driver specific leaves the potential for
> inconsistencies.

The problem is that AC or DC is not a generic property of backlights but
specific to your problematic hardware case. You're going to have a to
find a way to tell if its running on AC or not to report the right value
in the manner the class requires.

I can't see how you plan to add "generic support for displaying separate
AC and DC brightnesses" without destroying the point of the class (which
for the brightness parameter is to display the current backlight
brightness).

Richard

