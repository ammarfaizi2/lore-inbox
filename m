Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWGML6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWGML6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWGML6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:58:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57017 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964780AbWGML6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:58:36 -0400
Date: Thu, 13 Jul 2006 13:58:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Olaf Hering <olaf@aepfle.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
Message-ID: <20060713115800.GE5675@elf.ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711044834.GA11694@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > So anyone who likes to see klibc merged, because it will solve some kind 
> > of problem for him, please speak up now. Without this information it's 
> > hard to judge whether we're going to solve the right problems.
> 
> I do not want to see kinit merged.
> It (the merge into linux-2.6.XY) doesnt solve any real problem in the long term.
> Instead, make a kinit distribution. Let it install itself into an obvious
> location on the development box (/usr/lib/kinit/* or whatever), remove all
> code behind prepare_namespace() and put a disclaimer into the Linux 2.6.XY
> releasenote stating where to grab and build a kinit binary:
> make && sudo make install
> It can even provide its own CONFIG_INITRAMFS_SOURCE file, so that would
> be the only required change to the used .config.
> 
> The rationale is that there are essentially 2 kind of consumers:
> 
> One is the kind that builds static kernels and uses no initrd of any kind.
> For those people, the code and interfaces behind prepare_namespace() has
> not changed in a long time.
> They will install that kinit binary once and it will continue to work with

That is the problem... kernel did not use to depend on kinit, and this
is considered stable series. So if kernel wants to depend on kinit, it
needs to ship it itself.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
