Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTD0Sv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 14:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTD0Sv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 14:51:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:29638 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261404AbTD0Sv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 14:51:27 -0400
Date: Sun, 27 Apr 2003 20:59:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Andrew Morton <akpm@digeo.com>, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030427185956.GA238@elf.ucw.cz>
References: <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz> <20030424154608.V26054@schatzie.adilger.int> <1051232975.1919.26.camel@laptop-linux> <20030425125918.GA25733@atrey.karlin.mff.cuni.cz> <20030425102014.A26054@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425102014.A26054@schatzie.adilger.int>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Sounds like a good idea to me.
> > 
> > When I do sys_sync(), will it trigger that?
> 
> No, having sys_sync() do journal purging would really hurt journal fs
> performance.  That's why I said you need to call sync_supers_lockfs(),
> which is unfortunately not in 2.4 kernels (available in the LVM CVS
> as a patch), but it does appear to be in 2.5 kernels.  For
> journaling

(Second thought).

Its okay. We do sys_sync. If machine fails to resume, normal journal
recovery happens; nothing bad. It would be nice to
sync_supers_lockfs(), but if we need to have list of block devices for
that, its just too much trouble. Data are safe, anyway.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
