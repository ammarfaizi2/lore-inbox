Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbTDXJZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTDXJZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:25:06 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:56004 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262515AbTDXJZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:25:04 -0400
Date: Thu, 24 Apr 2003 11:35:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: ncunningham@clear.net.nz, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424093534.GB3084@elf.ucw.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay> <20030423235820.GB32577@atrey.karlin.mff.cuni.cz> <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au> <1051143408.4305.15.camel@laptop-linux> <20030423173720.6cc5ee50.akpm@digeo.com> <20030424091236.GA3039@elf.ucw.cz> <20030424022505.5b22eeed.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424022505.5b22eeed.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > No, ext3 will be "unclean" during resume (you can't really unmount it
> > during suspend!) and r-o mounting of ext3 will replay journal and
> > cause data corruption.
> 
> Sorry, I still don't get it.  Go through the steps for me:
> 
> 1) suspend writes pages to disk
> 
> 2) machine is shutdown
> 
> 3) restart, journal replay
> 
> 4) resume reads pages from disk.

And now you have kernel which expects data still in journal (that was
state before suspend), but reality on disk is quite different (journal
was replayed). Data corruption.

Simple enough steps?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
