Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVHBKJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVHBKJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVHBKHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:07:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64489 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261470AbVHBKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:04:45 -0400
Date: Tue, 2 Aug 2005 12:04:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050802100435.GC1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122908972.18835.153.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Why are we calling driver suspend routines in these ? This is _not_ a
> good idea ! On various machines, the mecanisms for shutting down are
> quite different from suspend/resume, and current drivers have too many
> bugs to make that safe. I keep getting all sort of reports of machines

Well, powerdown at the end of suspend-to-disk should be *very* similar
to normal powerdown => if device_suspend() breaks something, it is a
bug in driver anyway.

Now, we may have a lot of such bugs, and the change went in too early,
but in the long run...
-- 
teflon -- maybe it is a trademark, but it should not be.
