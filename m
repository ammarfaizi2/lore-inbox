Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWAQX1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWAQX1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAQX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:27:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27400 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751106AbWAQX1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:27:09 -0500
Date: Wed, 18 Jan 2006 00:27:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060117232701.GA7606@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD67AE.9030501@eyal.emu.id.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 08:54:54AM +1100, Eyal Lebedinsky wrote:
> Linus Torvalds wrote:
> > Ok, it's two weeks since 2.6.15, and the merge window is closed.
> 
> I am looking at a problem where the build seems to remove /dev/null,
> which is then created as a regular file (naturally). This did not
> happen before.
> 
> # ls -l /dev/null
> crw-rw-rw-  1 root root 1, 3 Jan 18 08:42 /dev/null
> # make distclean
>   CLEAN   scripts/basic
>   CLEAN   scripts/kconfig
>   CLEAN   include/config
>   CLEAN   .config .config.old include/asm include/linux/autoconf.h include/linux/version.h .kernelrelease
> # ls -l /dev/null
> -rwxr-xr-x  1 root root 47 Jan 18 08:42 /dev/null

Strange.
I have tried to reproduce without luck...
Can you please do above steps again with V=1 added like this:
ls -l /dev/null
make distclean V=1
ls -l /dev/null

Not a fix - but do not build as root....

	Sam
