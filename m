Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTFGUbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTFGUbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:31:05 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:20917 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263632AbTFGUbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:31:02 -0400
Date: Sat, 7 Jun 2003 22:43:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, vojtech@suse.cz
Subject: Re: [PATCH] Making keyboard/mouse drivers dependent on CONFIG_EMBEDDED
Message-ID: <20030607204340.GC667@elf.ucw.cz>
References: <20030607063424.GA12616@averell> <20030607082651.A18894@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607082651.A18894@infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > I finally got sick of seeing bug reports from people who did not enable
> > CONFIG_VT or forgot to enable the obscure options for the keyboard
> > driver. This is especially a big problem for people who do make oldconfig
> > with a 2.4 configuration, but seems to happen in general often.
> > I also included the PS/2 mouse driver. It is small enough and a useful
> > fallback on any PC.
> > 
> > This patch wraps all this for i386/amd64 in CONFIG_EMBEDDED. If 
> > CONFIG_EMBEDDED is not defined they are not visible and always enabled.
> 
> This sounds like a bad idea.  many modern PCs only have usb keyboard/mouse
> these days.  Having them in defconfig is fine but we shouldn't obsfucate
> the kernel config due to user stupidity.

Its more like "make oldconfig" limitation, IIRC. If you have some old
config, it ignores defconfig and suggests you N for new options. And
yes people were hitting that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
