Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTL1OqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbTL1OqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:46:12 -0500
Received: from gprs214-173.eurotel.cz ([160.218.214.173]:23169 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261575AbTL1OqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:46:06 -0500
Date: Sun, 28 Dec 2003 15:47:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 swsusp
Message-ID: <20031228144707.GA1489@elf.ucw.cz>
References: <173c01c3cceb$07352490$43ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173c01c3cceb$07352490$43ee4ca5@DIAMONDLX60>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On a machine with working ACPI, I compiled 2.6.0 with Software Suspend
> (Experimental).
> 
> 1.  Help information says that the next boot can be done with
> "resume=/dev/swappartition" or with "noresume".  It does not say how the
> swsusp command decides which swap partition to save to.  The man page (which
> still isn't sure if the command is named swsusp or suspend) also doesn't
> say.  How can I guess which swap partition to designate at resume time?  For
> the moment this is a hypothetical question because I haven't needed to make
> a second swap partition on this machine yet.

You have to have just one swap partition for now.

> 2.  When I forgot to say either "resume" or "noresume", the kernel detected
> that it could not use the swap partition, but it did not offer the
> possibility to resume.  Surely it could detect early enough that the swap
> partition is not usable for swap but is usable for resume, and could ask the
> user whether to do a "resume" or "noresume".

At *that* point, it is no longer possible to resume safely.

> 3.  When swsusp completed its writing, it decided that my ACPI BIOS could
> not power off automatically.  I wonder why.  No other OS has trouble
> powering off this machine.  Also on machines with older APM BIOSes, no OS
> had trouble powering off the machines, not even Linux with APM drivers.  So
> I could hold the power switch for 4 seconds and the BIOS beeped a warning
> before powering off, but I wonder why it was necessary.

If regular halt is also unable to power off machine, fill the bug in
ACPI bugzilla.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
