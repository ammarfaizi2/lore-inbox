Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVAQEuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVAQEuD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVAQEuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:50:03 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:24860 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262686AbVAQEtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:49:39 -0500
Date: Mon, 17 Jan 2005 05:49:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sparse refuses to work due to stdarg.h
Message-ID: <20050117044955.GA8092@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
References: <20050116224922.GA4454@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116224922.GA4454@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 11:49:22PM +0100, Pavel Machek wrote:
> Hi!
> 
> I'm probably doing something wrong, but... how do I force it to work?
> I'm pretty sure it worked before, I'm not sure what changed in my
> config.

kbuild was changed to reliably pick up the stdarg.h for the gcc used.
Two issues has popped up:
1) sparse did not support -isystem dir
	- fixed a few days ago, and fix is at sparse.bkbits.net
2) misconfigured gcc's that report a wrong directory when using
gcc -print-file-name=include
The directory given must include stdarg.h - otherwise gcc config is
broken.

You are hit by 1)

	Sam
