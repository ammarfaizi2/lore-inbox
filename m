Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbULMMSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbULMMSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbULMMSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:18:10 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:8941 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262235AbULMMSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:18:08 -0500
To: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume from PCI devices
In-Reply-To: <200412100315.21725.shawn.starr@rogers.com>
References: <200412100315.21725.shawn.starr@rogers.com>
Date: Mon, 13 Dec 2004 12:18:07 +0000
Message-Id: <E1Cdp9T-0006Xy-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr <shawn.starr@rogers.com> wrote:

> I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).

2.6.10-rc3 won't resume unless you unload sound drivers beforehand or
add one of the patches that fixes pci_disable_device with ALSA.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
