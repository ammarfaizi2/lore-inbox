Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbWHXQWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWHXQWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHXQWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:22:09 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:55187 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030353AbWHXQWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:22:07 -0400
Date: Thu, 24 Aug 2006 17:20:34 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: moreau francis <francis_moreau2000@yahoo.fr>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re : [HELP] Power management for embedded system
Message-ID: <20060824162034.GB19753@srcf.ucam.org>
References: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com> <1156414325.5555.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156414325.5555.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 11:12:05AM +0100, Richard Purdie wrote:

> It would be nice to move that to some arch independent generic
> implementation of these things and to leave the APM emulation behind.
> The battery information should be a sysfs class (see the backlight/led
> classes as examples of sysfs classes). The suspend/resume event handling
> would be something new as far as I know and ideally should support
> suspending/resuming individual sections of device hardware as well as
> the whole system.

Triggering suspend/resume is already generic in the form of the 
/sys/power/state interface. There's been discussion of producing a 
generic battery class lately. There's some trend towards tying suspend 
requests into the input layer, but how appropriate that is may depend on 
the hardware in question. I think most of the pieces are in place to 
provide an interface that isn't tied to looking like APM, and there's 
certainly one or two moderately compelling reasons to avoid the APM 
emulation limitations.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
