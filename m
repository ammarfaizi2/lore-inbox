Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULTOzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULTOzv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 09:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULTOzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 09:55:51 -0500
Received: from web88006.mail.re2.yahoo.com ([206.190.37.193]:43671 "HELO
	web88006.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261515AbULTOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 09:55:44 -0500
Message-ID: <20041220145543.56059.qmail@web88006.mail.re2.yahoo.com>
Date: Mon, 20 Dec 2004 09:55:43 -0500 (EST)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: Cannot resume from PCI devices [now: Drivebay LED light going into S3]
To: linux-kernel@vger.kernel.org
Cc: borislav@users.sf.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, the ALSA fix is in (don't know which -bk it was
added) but it works fine with -bk13 as
pci_disable_device now is in there.

Boris, when we go into S3 mode, the drivebay light
remains on, draining power.. How can this be shut off
when we enter S3? aside from manually shutting the LED
off before suspend. Any code hooks we can trigger apon
entering S3?

Shawn.

>List:       acpi4linux
>Subject:    [ACPI] [ACPI][2.6.10-rc3][SUSPEND] S3
mode - Cannot resume from PCI devices
>From:       Shawn Starr
>Date:       2004-12-10 8:15:21

>I have netconsole configured I can see kernel
messages >on a remote machine, but when I suspend the
laptop it >goes into S3. I am unable to capture the
(oops) the >laptop when bringing it out of S3. It
remains in a >half suspended-unsuspended state. (the
crescent moon >LED is solidly on, video is back on
(can see the 'Back >to C!' string), cannot use sysctl
key combos,  >netconsole doesn't display the output
since no PCI >devices resume (the video is AGP
onboard).

>Is there any way I can capture this output somehow? I
>don't think even serial would work (it would be a USB
>to serial converter which would be PCI) or even
trying >to get this to print to lp0 since the laptop
is >totally unresponsive in its state.

>I booted into single and sh for init, mounted /proc
>/sys and with no kernel modules it would fail to
>resume after suspending.

>This isn't a nice regression.

>Shawn.
