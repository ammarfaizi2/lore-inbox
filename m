Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUILVAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUILVAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUILVAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:00:35 -0400
Received: from gprs40-135.eurotel.cz ([160.218.40.135]:6321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261711AbUILVAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:00:24 -0400
Date: Sun, 12 Sep 2004 23:00:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Merging swsusp
Message-ID: <20040912210011.GA3322@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Configuration of my provider changed and now I'm in blacklist. Anyway,
it looks like swsusp2 is closer to merge...

...
<ncunningham@linuxmail.org>: host linuxmail-org.mr.outblaze.com[205.158.62.52]
    said: 554 EMail from mailserver at 160.218.40.135 is refused. See
    http://spamblock.outblaze.com/160.218.40.135 (in reply to RCPT TO command)
...

Hi!

> At long last I'm approaching readiness for merging. I have a patch still
> to apply to this tree and some functional rearrangement of patches to
> do, but I've got the following at the moment. Is it the sort of thing
> you want to see? I plan to submit the patches in groups:
> 
> 1. Little patches that pass on fixes submitted by various people (giving
> credit of course): ati-agp, ne2k, ali5451, alps for example.
> 2. Refrigerator improvements (workthreads, refrigerator proper,
> proccess.c replacement).
> 3. New exports for building suspend as modules.
> 4. Nosave improvements in mm init.
> 5. New code to disable mce, slab reap, oom killer etc while suspending
> (things the mess up a two-step image save/restore or should otherwise be
> put on ice) and to add hooks for suspend.
> 6. Arch specific lowlevel code (currently mac/ppc and x86. x86_64 to
> follow shortly).
> 7. Always-built-in suspend code.
> 8. Suspend core module.
> 9. Suspend user interface modules.
> 10. Suspend compression modules (encryption also planned).
> 11. Suspend image writer modules (generic file writer planned).
> 12. Documentation patches.

Looks good.

> I'm sure that there will be plenty of suggestions as to how I can do
> things better, so I'm not deluding myself into thinking this will all be
> accepted immediately. Nevertheless, I want to get your initial thoughts.
> By the way, will this be too many/too large to post to LKML as well?

I believe it should be okay on linux-kernel. Individual patches are
quite small.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


----- End forwarded message -----

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
