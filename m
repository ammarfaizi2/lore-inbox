Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWF3Xcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWF3Xcl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWF3Xcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:32:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55427 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932129AbWF3Xck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:32:40 -0400
Date: Sat, 1 Jul 2006 01:32:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
Message-ID: <20060630233212.GH1717@elf.ucw.cz>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A5AE17.4080106@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-01 03:04:55, Michael Tokarev wrote:
> Pavel Machek wrote:
> [klibc/kinit in kernel]
> > I'd like to eventually move swsusp out of kernel, and klibc means I
> > may be able to do that without affecting users. Being in kinit is good
> > enough, because I can actually share single source between kinit
> > version and suspend.sf.net version.
> 
> Heh.  Take a look at anyone who's using real initramfs for their boot
> process.  Not initrd, not kernel-without-any-preboot-fs, but real
> initramfs.  For them, if kinit/klibc will be in kernel, nothing changes,
> because their initramfs *replaces* in-kernel code and future supplied-
> with-kernel-klibc-based-kinit.  So if you'll move swsusp into kinit,
> it WILL break setups for those users!.. ;)

Distros will probably want to use "real" code from swsusp.sf.net, not
stripped down version, provided for back compatibility with kernel.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
