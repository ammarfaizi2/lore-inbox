Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTEIRBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbTEIRBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:01:07 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:22196 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263349AbTEIRBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:01:06 -0400
Date: Fri, 9 May 2003 19:11:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl32_unregister_conversion & modules
Message-ID: <20030509171155.GA1042@elf.ucw.cz>
References: <20030509100039$6904@gated-at.bofh.it> <200305091213.h49CDuO4029947@post.webmailer.de> <20030509152436.GA762@elf.ucw.cz> <1052496782.19951.3.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052496782.19951.3.camel@rth.ninka.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Fixing that would require resgister_ioctl32_conversion() to have 3-rd
> > parameter "this module" and some magic inside fs/compat_ioctl.c,
> > right?
> 
> That would do it.  I would suggest seperating out the static translation
> handlers and the dynamically registered ones.  Now that you're adding
> in module owner info, the translation tables are going to start bloating
> up like crazy.
> 
> I'm still upset about going from 32-bit --> 64-bit entries on
> sparc64 :-(

So... Do you think moving common handlers from arch/*/ioctl32.c into
fs/compat_ioctl.c would do the trick?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
