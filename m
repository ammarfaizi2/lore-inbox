Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266056AbUGTRqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266056AbUGTRqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUGTRqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 13:46:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:926 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266056AbUGTRqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 13:46:12 -0400
Date: Tue, 20 Jul 2004 19:46:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nathan Bryant <nbryant@optonline.net>
Cc: linux-scsi@vger.kernel.org, random1@o-o.yi.org,
       Luben Tuikov <luben_tuikov@adaptec.com>, benh@kernel.crashing.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
Message-ID: <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
References: <40FD38A0.3000603@optonline.net> <20040720155928.GC10921@atrey.karlin.mff.cuni.cz> <40FD4CFA.6070603@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FD4CFA.6070603@optonline.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Can you kill #if 0 code?
> 
> Yes. This is a work in progress. Interestingly, the ifdef'd-out code was 
> pasted from mptbase.c in the MPT Fusion driver. If it's broken here, 
> it's probably broken there -- seems the state parameter passed to the 
> pci resume callback is intended to be a PCI D state, not an ACPI S 
> state. Can somebody confirm or deny? The kernel is actually passing 
> state 2 (D2) to the driver when I enter ACPI S3, so presumably the same 
> failure could happen to fusion.

I'm no longer sure what should be passed there... We'll probably need
to turn it into enum... Actually swsusp code in -mm actually passes
value from enum, and mainline swsusp code passes 0/3. 

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
