Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTDXAQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTDXAQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:16:07 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19134 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264326AbTDXAQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:16:05 -0400
Date: Wed, 23 Apr 2003 17:26:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: cat@zip.com.au, akpm@digeo.com, pavel@ucw.cz, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-Id: <20030423172628.0f71ab64.rddunlap@osdl.org>
In-Reply-To: <1051143408.4305.15.camel@laptop-linux>
References: <1051136725.4439.5.camel@laptop-linux>
	<1584040000.1051140524@flay>
	<20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
	<20030423170759.2b4e6294.akpm@digeo.com>
	<20030424001733.GB678@zip.com.au>
	<1051143408.4305.15.camel@laptop-linux>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003 12:16:48 +1200 Nigel Cunningham <ncunningham@clear.net.nz> wrote:

| On Thu, 2003-04-24 at 12:17, CaT wrote:
| > I'm curious. What does a swapfile solve that a swapdev does not? Either
| > way you need to prealloc the case (either have a chunky file in a
| > partition or a partition set aside) or you need to keep enough room
| > avail to fit the file when it's needed.
| 
| Nothing but further bloat in swsusp :> With a swapfile, we need to know
| the location of the file (and be able to find it again when it changes,
| and know how to find the next block in the file system - it might be
| fragmented). The simplest solution is to keep using the current method
| and create a separate swap partition if you really feel you need to,
| only turning it on before swap and turning if off afterwards. As Pavel
| said, code could be added to get swsusp to do it itself.

That may be simple for you, but for lots of users, adding a partition
(to a ususally full disk drive) isn't simple.  It means backups,
shrink a filesystem, shrink a partition, add a partition, and run
mkswap on it.   Yes, the latter 2 are simple, but the former ones
are not.

Oh, and then just start over and install everything from backups. :(

--
~Randy
