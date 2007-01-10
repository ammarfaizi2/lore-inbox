Return-Path: <linux-kernel-owner+w=401wt.eu-S932469AbXAJNhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbXAJNhO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXAJNhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:37:14 -0500
Received: from smtp.nokia.com ([131.228.20.172]:32434 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469AbXAJNhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:37:12 -0500
Message-ID: <45A4ECDF.8090707@indt.org.br>
Date: Wed, 10 Jan 2007 09:40:47 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] Add MMC Password Protection (lock/unlock) support
 V9: mmc_sysfs.diff
References: <4582F007.7030100@indt.org.br> <459B9C4E.3020406@indt.org.br> <45A021B2.4090104@drzeus.cx>
In-Reply-To: <45A021B2.4090104@drzeus.cx>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jan 2007 13:35:30.0840 (UTC) FILETIME=[32756980:01C734BC]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> I've queued it up for -mm, but there a few more comments I want resolved
> before this can move to Linus...

Ok, thanks for the revisions.
> 
> You need to clean up mmc_lockable_store(). It had a few broken variable
> declarations that even prevented it from compiling, and after I fixed
> that I still get:
> 
> drivers/mmc/mmc_sysfs.c: In function ‘mmc_lockable_store’:
> drivers/mmc/mmc_sysfs.c:160: warning: ignoring return value of
> ‘device_attach’, declared with attribute warn_unused_result
> drivers/mmc/mmc_sysfs.c:93: warning: ‘mmc_key’ may be used uninitialized
> in this function

I did a modification at this patch and did not get those warnings anymore.
> 
> There's also no handling for an invalid string written to the sysfs node.

Is this really needed? I thought the function just ignored other values sent to itself that were not handled.

> 
> And third, you're a bit excessive on the goto:s. E.g. out_unlocked is
> used in a single place, so it is completely unnecessary. Please do a
> general cleanup of the control flow.

Ok.

Regards,

Anderson Briglia
