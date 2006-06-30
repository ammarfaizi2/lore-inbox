Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWF3UWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWF3UWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWF3UWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:22:14 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:6151 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751118AbWF3UWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:22:12 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
References: <m2irmj9937.fsf@phoenix.squirrel.nl>
	<20060630180141.GC9225@elf.ucw.cz>
From: Johan Vromans <jvromans@squirrel.nl>
Date: Fri, 30 Jun 2006 22:22:04 +0200
In-Reply-To: <20060630180141.GC9225@elf.ucw.cz> (Pavel Machek's message of
 "Fri, 30 Jun 2006 20:01:41 +0200")
Message-ID: <m2y7vetmvn.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Stop right here. Can you reproduce the problem without ATI driver?
> Reproducing it on vanilla kernel (not -FC5) would be nice, too.

A lot of suspend/reboot/resumes later...

The problem does not seem to be related to the ATI driver, but whether
or not the pm-suspend program is used. With the Xorg driver I get the
same problem when I suspend with

  echo shutdown > /sys/power/disk; echo disk > /sys/power/state

When I use pm-hibernate suspend/resume seems works okay (with Xorg and
ATI driver).

With 2.6.16, I did not have the need to use pm-hibernate. So something
changed here.

As mentioned in my OP using pm-hibernate does not give any feedback
what is going on (except for the disk led). I find this annoying.
Another annoyance is that pm-hibernate locks this kernel for the next
reboot, so it is not possible to boot something else and resume
later.

Apart from that, suspend/resume is a life saver!

(Now it would be nice to get suspend to memory working. It seems to
suspend okay, but I haven't found out how to resume...)

-- Johan
