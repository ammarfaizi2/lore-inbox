Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUIPUaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUIPUaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUIPUaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:30:03 -0400
Received: from gprs214-49.eurotel.cz ([160.218.214.49]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268200AbUIPU37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:29:59 -0400
Date: Thu, 16 Sep 2004 21:22:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: JBeulich@novell.com
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>, seife@suse.de
Subject: swsusp: solving build issue leads to crash on x86-64
Message-ID: <20040916192208.GA1009@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Do you remember that build issue, where you needed to added ', "aw"'
to make linker happy? Well, too late I found that it breaks swsusp in
quite a ugly way. Try it on x86-64: it works without "aw", breaks with
it.

I'm doing this for now. I'll probably just rewrite assemlby not to
require those variables, but understanding what went wrong there would
be welcome.

#       .section .data.nosave, "aw"
        .section .data.nosave
        .align 8
loop:
        .quad 0
loop2:
        .quad 0
        .previous

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
