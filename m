Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSBLQzz>; Tue, 12 Feb 2002 11:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289663AbSBLQzp>; Tue, 12 Feb 2002 11:55:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21508 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288238AbSBLQzf>;
	Tue, 12 Feb 2002 11:55:35 -0500
Date: Tue, 12 Feb 2002 17:55:18 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
Message-ID: <20020212175518.N1907@suse.de>
In-Reply-To: <20020212092658.Z729@suse.de> <E16ae1e-0001ws-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ae1e-0001ws-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Alan Cox wrote:
> > > > I want to find out why it was done first and then test it. Leaving it out
> > > > will ensure it bugs me until I test it
> > > 
> > > If you leave it out, you surely want to make sure that the other request
> > > init and re-init paths agree on the clustering for MO devices. Because
> > > they don't.
> 
> No - I want to run a test set with an M/O drive before and after the change
> and see what it shows in real life. I suspect nothing much.

That completely ignores that there is a _bug_ there currently. There was
a reason I removed disabled clustering, you know... 2.4 before the
change oopses, 2.4.18-preX (forget when Marcelo took the patch) has it
fixed.

> > Now, disabling request merging for MO devices might make a whole lot
> > more sense. That might be worth while trying, and I'd be happy to give
> > you a patch to try that out instead.
> 
> I don't think that should be required actually. The killer on M/O disks
> is seek time, and to an extent rotational latency (its 3 trips round a 
> cheaper M/O disk to rewrite a sector). If anything clustering writes to
> the same track should be a big win.

You are probably right. Can't make pigs fly :-)

-- 
Jens Axboe

