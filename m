Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVCSV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVCSV3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCSV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:29:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:24533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261827AbVCSV3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:29:01 -0500
Date: Sat, 19 Mar 2005 13:28:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: swsusp: Remove arch-specific references from generic code
Message-Id: <20050319132815.4f51a7e5.akpm@osdl.org>
In-Reply-To: <200503191159.32569.rjw@sisk.pl>
References: <20050316001207.GI21292@elf.ucw.cz>
	<200503191159.32569.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Wednesday, 16 of March 2005 01:12, Pavel Machek wrote:
>  > Hi!
>  > 
>  > This is fix for "swsusp_restore crap"-: we had some i386-specific code
>  > referenced from generic code. This fixes it by inlining tlb_flush_all
>  > into assembly.
>  > 
>  > Please apply,
> 
>  Unfortunately, this patch requires the following fix.  Without it, swsusp will
>  leak lots of memory on every resume.  Sorry for this bug, it was really dumb.

Just fyi, the only swsusp patches I currently have queued are

swsusp-add-missing-refrigerator-calls.patch
swsusp-suspend_pd_pages-fix.patch
suspend-to-ram-update-videotxt-with-more-systems.patch

I've been ducking all the "swsusp_restore crap" patches.  Pavel, could you
please aggregate, test and resend everything when the dust has settled?

