Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265542AbUGDMDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbUGDMDO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUGDMDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:03:14 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:48518 "EHLO
	mailfe06.swip.net") by vger.kernel.org with ESMTP id S265542AbUGDMDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:03:13 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Sun, 4 Jul 2004 13:49:20 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/power/swsusp.c
Message-ID: <20040704114920.GA7820@linux.nu>
References: <20040703172843.GA7274@linux.nu> <20040703204647.GE31892@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703204647.GE31892@elf.ucw.cz>
X-GPG-Key: Search for erkki@linux.nu at wwwkeys.eu.pgp.net
X-GPG-Fingerprint: 0534 CF05 8171 3EC6 921A  346F 1882 91C4 993F C709
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 10:46:47PM +0200, Pavel Machek wrote:
> You are moving it inside function that should have no business doing
> this... Would something like this work better? [hand-edited, apply by
> hand; untested].
I'll try it.

> BTW is bootsplash actually used by suse and/or redhat? Suse certainly
Suse uses bootsplash. Even without bootsplash the console jumps to a new vc
then back at every boot, on systems with bootsplash and/or slow systems this
causes the screen to flicker.

> has some splashscreen... Perhaps some splash support into swsusp (as
> an add on) would be good idea, but it would be good to only code it
> once.
That is infact my intention. I've looked some at the swsusp2 code but it
looks ugly. My plan is to create a general kernel level interface to
bootsplash, then add hooks in swsusp. This code should probably live in the
bootsplash patch.

Erik
