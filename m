Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTDXIlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTDXIlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:41:11 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:3467 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261840AbTDXIlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:41:08 -0400
Date: Thu, 24 Apr 2003 02:25:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: mbligh@aracnet.com, ncunningham@clear.net.nz, gigerstyle@gmx.ch,
       geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424002544.GC2925@elf.ucw.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423170759.2b4e6294.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you really want to "solve" it reliably, you can always
> > 
> > swapon /dev/hdfoo666
> > 
> 
> Seems that using a swapfile instead of a swapdev would fix that neatly.
> 
> But iirc, suspend doesn't work with swapfiles.  Is that correct?  If so,
> what has to be done to get it working?

Swapfile does not work, because even readonly mount wants to replay
logs, and that'd be disk corruption.

It could be doable with modifications to the filesystems, but it would
be hard (and I do not think it is worth it).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
