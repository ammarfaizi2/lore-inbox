Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWBGNXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWBGNXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWBGNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:23:46 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:22147 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965076AbWBGNXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:23:45 -0500
Date: Tue, 7 Feb 2006 13:23:34 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060207132334.GA2331@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org> <20060206191916.GB17460@srcf.ucam.org> <20060207003748.GA22510@srcf.ucam.org> <200602062237.55653.dtor_core@ameritech.net> <20060207123204.GA1423@srcf.ucam.org> <1139317605.6422.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139317605.6422.26.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 01:06:45PM +0000, Richard Purdie wrote:

> This is total abuse of the backlight class. The idea is that
> cat /sys/class/backlight/ccc/brightness returns the *current* backlight
> brightness. On AC power it should return the AC brightness value and on
> DC power return the DC value.

Unfortunately, the hardware doesn't seem to give us that option. There's 
no obvious way of determining whether we're on AC or DC from the kernel 
without doing very nasty things with ACPI and APM (userspace can work it 
out fairly easily).

Would you be open to adding generic support for displaying separate AC 
and DC brightnesses? Making it driver specific leaves the potential for
inconsistencies.
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
