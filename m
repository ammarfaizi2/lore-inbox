Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWBMMv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWBMMv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWBMMv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:51:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:49585 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932425AbWBMMv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:51:29 -0500
Date: Mon, 13 Feb 2006 13:51:17 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Roger Leigh <rleigh@whinlatter.ukfsn.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Message-ID: <20060213125117.GA18119@suse.de>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org> <20060212195514.GA18521@suse.de> <20060213105701.GA15476@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060213105701.GA15476@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Feb 13, Olaf Hering wrote:

>  On Sun, Feb 12, Olaf Hering wrote:
> 
> >  On Sun, Feb 12, Roger Leigh wrote:
> > 
> > > In both these cases, the chrony NTP daemon is running, if that might
> > > be a problem.
> > 
> > I dont run Debian, but:
> > 
> > My G4/466 has the hwclock at 1970 for some reason. The early bootscripts
> > call klogd, which calls nanosleep. This syscall takes 3 hours to complete.

nanosleep is usually called with *rqtp <something>, *rmtp NULL.
Only in the klogd case both pointers are equal.
