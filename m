Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVCAKzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVCAKzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 05:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVCAKzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 05:55:08 -0500
Received: from gprs215-195.eurotel.cz ([160.218.215.195]:15330 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261864AbVCAKzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 05:55:03 -0500
Date: Tue, 1 Mar 2005 11:54:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, barryn@pobox.com, marado@student.dei.uc.pt,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
Message-ID: <20050301105448.GG1345@elf.ucw.cz>
References: <20050228231721.GA1326@elf.ucw.cz> <20050301015231.091b5329.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301015231.091b5329.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In `subj` kernel, machine no longer powers down at the end of
> >  swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
> 
> Binary searching indicates that this is due to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/acpi_power_off-bug-fix.patch.
> 
> I'll drop it.  That patch is pretty ugly-looking anyway (ACPI code in
> drivers/base/power/?).
> 
> Perhaps someone who is hitting the problem which that patch addresses could
> raise a bugzilla entry.
> 
> Oh.  It has one.  http://bugme.osdl.org/show_bug.cgi?id=4041
> 
> Anyway.  It needs more work.

Yes, the patch is very ugly. If something like this needs to be done,
then perhaps acpi should properly register into driver model and do
the work there. This will also mean code will be called consistently.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
