Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWF3XFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWF3XFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWF3XFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:05:01 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:7777 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750802AbWF3XFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:05:00 -0400
Message-ID: <44A5AE17.4080106@tls.msk.ru>
Date: Sat, 01 Jul 2006 03:04:55 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Roman Zippel <zippel@linux-m68k.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz>
In-Reply-To: <20060630181131.GA1709@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
[klibc/kinit in kernel]
> I'd like to eventually move swsusp out of kernel, and klibc means I
> may be able to do that without affecting users. Being in kinit is good
> enough, because I can actually share single source between kinit
> version and suspend.sf.net version.

Heh.  Take a look at anyone who's using real initramfs for their boot
process.  Not initrd, not kernel-without-any-preboot-fs, but real
initramfs.  For them, if kinit/klibc will be in kernel, nothing changes,
because their initramfs *replaces* in-kernel code and future supplied-
with-kernel-klibc-based-kinit.  So if you'll move swsusp into kinit,
it WILL break setups for those users!.. ;)

And with time, amount of such users increases.  Because everyone's
switching from initrd to initramfs; or because everyone's starting
using initramfs (not initrd as "obsolete") since their systems now
require some sort of custom stuff while mounting root (like firmware
loading, or device-mapper setup for sata pseudo-raids, or whatever).

Oh well.

/mjt
