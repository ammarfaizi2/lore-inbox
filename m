Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUBHKcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 05:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUBHKcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 05:32:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41164 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263125AbUBHKca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 05:32:30 -0500
Date: Sun, 8 Feb 2004 11:32:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Eduard Bloch <edi@gmx.de>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040208103222.GX11683@suse.de>
References: <20040203174606.GG3967@aurora.fi.muni.cz> <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk> <yw1xn080m1d2.fsf@kth.se> <Pine.LNX.4.53.0402031509100.32547@chaos> <20040203224021.GK11683@suse.de> <1075849526.11322.9.camel@nosferatu.lan> <200402040737.i147bJqq000455@81-2-122-30.bradfords.org.uk> <20040205233113.GA10254@zombie.inka.de> <200402060758.i167whxX000498@81-2-122-30.bradfords.org.uk> <20040208101557.GA25053@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208101557.GA25053@zombie.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08 2004, Eduard Bloch wrote:
> Moin John!
> John Bradford schrieb am Friday, den 06. February 2004:
> 
> > > > unmounted before an erase, when it is re-mounted, the stale data is
> > > > read from the device's own cache, which should have been invalidated
> > > > by the erase.
> > > 
> > > Is it realy a hardware issue?
> > 
> > I originally thought so, but maybe I was wrong.  Jens posted a patch
> > to invalidate kernel buffers on an umount - if the problem persists
> > with that patch, I still believe it is a hardware fault.
> 
> And I don't. One of the cdrtools Debian maintainers just wrote that the
> patch does NOT solve the problem with the scenario described above in
> the thread.

Perhaps another program has the device open still? In that case, we
don't invalidate the toc cache.

-- 
Jens Axboe

