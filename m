Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVCGJfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVCGJfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVCGJfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:35:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64731 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261723AbVCGJfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:35:24 -0500
Date: Mon, 7 Mar 2005 10:35:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Stefan Seyfried <seife@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC is   also enabled
Message-ID: <20050307093512.GE8311@elf.ucw.cz>
References: <20050306030852.23eb59db.akpm@osdl.org> <20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org> <422C0A6B.1060700@suse.de> <20050307092206.GB5083@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307092206.GB5083@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Isn't some Kconfig solution appropriate here?
> > 
> > Yes, but only for the CONFIG_DEBUG_PAGEALLOC case, it does not solve the
> > "cpu has no PSE" case for VIA CPUs. So the Kconfig solution is an extra
> > bonus.
> 
> Note that I've posted a Kconfig solution here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111017249931972&w=2
> 
> Regarding Pavel's patch, it seems to me that it might be better to print
> the message at boot time, instead of (or in addition to?) his patch.
> Maybe we should be disabling swsusp altogether at boot in that case, if
> that's not unreasonably hard to implement.

Hmm, yes, that would certainly be better. It would need new
per-architecture hook... Feel free to implement it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
