Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbVKBICX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVKBICX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVKBICX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:02:23 -0500
Received: from relay01.pair.com ([209.68.5.15]:9999 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932635AbVKBICX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:02:23 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: best way to handle LEDs
Date: Wed, 2 Nov 2005 02:01:45 -0600
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
References: <20051101234459.GA443@elf.ucw.cz> <1130891953.8489.83.camel@localhost.localdomain>
In-Reply-To: <1130891953.8489.83.camel@localhost.localdomain>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020202.07958.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 06:38 pm, Richard Purdie wrote:
> led triggers would be connected to leds via sysfs. Each trigger would
> probably have a number you could echo into an led's trigger attribute.
> Sensible default mappings could be had by assigning a default trigger to
> a device by name in the platform code that declares the led.
>
> A trigger of "0" would mean the led becomes under userspace control via
> sysfs for whatever userspace wishes to do with it.

Any reason to represent the triggers as numbers in sysfs? I'm a fan of how the 
IO scheduler is chosen on a block device. The file looks like:

noop [anticipatory] deadline cfq

You get a list of all available triggers, which one is active (and it's easy 
enough for user space code to parse). Obviously, to select a trigger, you 
just write its name to the file. Instead of 0, you say user, etc...

Cheers,
Chase Venters
