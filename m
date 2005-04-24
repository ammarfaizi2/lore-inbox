Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVDXAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVDXAtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVDXAtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:49:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:21424 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262209AbVDXAtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:49:06 -0400
Subject: Re: [2.6 patch] unexport is_console_locked
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050423164948.652cc82b.akpm@osdl.org>
References: <20050415151045.GK5456@stusta.de>
	 <20050423164948.652cc82b.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 10:51:30 +1000
Message-Id: <1114303890.5443.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-23 at 16:49 -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I didn't find any possible modular usage in the kernel.
> > 
> 
> Is needed for WARN_CONSOLE_UNLOCKED().
> 
> It just happens that WARN_CONSOLE_UNLOCKED() is currently only using in
> vt.c, which just happens to not support modular usage.
> 
> But disabling this export would make WARN_CONSOLE_UNLOCKED() pretty useless
> for driver development.
> 
> So I'd suggest that we either leave this symbol exported for driver
> developers or we nuke WARN_CONSOLE_UNLOCKED() altogether.
> 
> Ben, do you still want it?

Yes, I do. Please, keep it exported. On that note, I don't understand
that frenzy of unexporting everything you can, I find this useless
burden in general.

Ben.


