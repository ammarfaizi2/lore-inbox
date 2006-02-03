Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWBCKnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWBCKnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBCKnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:43:21 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:44754 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1751036AbWBCKnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:43:20 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
In-Reply-To: <20060203022305.2e619476.akpm@osdl.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe> <E1F4xZN-0001K1-00@chiark.greenend.org.uk> <E1F4xZN-0001K1-00@chiark.greenend.org.uk> <20060203022305.2e619476.akpm@osdl.org>
Date: Fri, 3 Feb 2006 10:43:15 +0000
Message-Id: <E1F4yPL-0003np-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Is it still the case that swsusp requries that the disk drivers be
> statically linked into vmlinux?

No, I submitted a patch for that that went into 2.6.13. In
initrd/initramfs, load the controller modules and then echo the
major:minor of the suspend device into /sys/power/resume. As long as
this is done before any filesystems are mounted, it works fine.

(Yes, it gives you the ability to shoot yourself in the foot, but then
so does the rest of the kernel...)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
