Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUHUQXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUHUQXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUHUQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 12:23:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266748AbUHUQXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 12:23:43 -0400
Date: Sat, 21 Aug 2004 18:23:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter =?iso-8859-1?Q?M=FCnster?= <pmlists@free.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] idle ide disk on resume
Message-ID: <20040821162336.GE7490@suse.de>
References: <fa.e71k2cf.qladil@ifi.uio.no> <Pine.LNX.4.58.0408211419040.973@gaston.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0408211419040.973@gaston.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21 2004, Peter Münster wrote:
> On Tue, 22 Jun 2004, Jens Axboe wrote:
> 
> > I need this patch to survive suspend on my powerbook, if the drive is
> > sleeping when suspend is entered. Otherwise it freezes on resume when it
> > tries to read from the drive.
> 
> Hello,
> unfortunately, with this patch the disk always wakes up when resuming (from
> ACPI S1), even if it does not need to.
> Could it be possible, to get previous behaviour, that is keeping disk
> sleeping when resuming?

We can probably kill the patch completely, I'm not so sure the missing
idle command was the reason for the drive hang. But my problematic case
was resuming with a previously suspended drive, so...

-- 
Jens Axboe

