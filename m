Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269564AbUJLI6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269564AbUJLI6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUJLI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:58:45 -0400
Received: from gprs213-46.eurotel.cz ([160.218.213.46]:14720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269534AbUJLI6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:58:11 -0400
Date: Tue, 12 Oct 2004 10:57:48 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1: swsusp not freeing memory on AMD64
Message-ID: <20041012085748.GD2292@elf.ucw.cz>
References: <200410112349.40551.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410112349.40551.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems that on 2.6.9-rc4-mm1 swsusp is unable to free memory on my AMD64 
> box:
> 
> Stopping tasks: 
> ========================================================================|
> Freeing memory...  done (0 pages freed)

Andrew, I'm afraid this one is for you. I call shrink_all_memory() and
vm system does not free anything. That looks like VM bug...

								Pavel
> On 2.6.9-rc3-mm3 it was OK.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
