Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbVKGSHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbVKGSHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVKGSHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:07:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61085 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965169AbVKGSHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:07:23 -0500
Date: Mon, 7 Nov 2005 19:07:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, shaohua.li@intel.com
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
Message-ID: <20051107180710.GD1710@elf.ucw.cz>
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz> <436F9720.8070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F9720.8070008@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >diff --git a/kernel/power/main.c b/kernel/power/main.c
> >--- a/kernel/power/main.c
> >+++ b/kernel/power/main.c
> >@@ -167,7 +167,7 @@ static int enter_state(suspend_state_t s
> > {
> > 	int error;
> > 
> >-	if (pm_ops->valid && !pm_ops->valid(state))
> >+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
> > 		return -ENODEV;
> > 	if (down_trylock(&pm_sem))
> > 		return -EBUSY;
> >
> >
> >  
> >
> 
> 
> i'm using ACPI.
> i'?ll try the patch and report asap.

ok, not sure what is going on, then. Fill enter_state() with printks()
so that we know where it fails... then kill klogd before attempting
suspend.
								Pavel
-- 
Thanks, Sharp!
