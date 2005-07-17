Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVGQQA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVGQQA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVGQQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 12:00:28 -0400
Received: from [67.70.253.242] ([67.70.253.242]:22536 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261315AbVGQQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 12:00:25 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] readd missing define to arch/um/Makefile-i386
Date: Sun, 17 Jul 2005 18:08:02 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050717145228.GA15771@suse.de>
In-Reply-To: <20050717145228.GA15771@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507171808.03035.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 July 2005 16:52, Olaf Hering wrote:
> New in 2.6.13-rc3-git4:

> scripts/Makefile.build:13: /Makefile: No such file or directory
> scripts/Makefile.build:64: kbuild: Makefile.build is included improperly

> the define was removed, but its still required to build some targets.

> Signed-off-by: Olaf Hering <olh@suse.de>
Yes, this patch is the correct fix, also for -rc3-mm1 (which has the same 
problem).

Andrew, I hadn't the time to look at how you fixed up rejects in last merge 
([PATCH] uml: allow building as 32-bit binary on 64bit host)*; the rejects 
came from the SKAS0 merge, and while you were fixing the patch up you deleted 
by mistake the line which is readded in this patch.

*
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=20d0021394c1b070bf04b22c5bc8fdb437edd4c5

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
