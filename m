Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262894AbSJAWcj>; Tue, 1 Oct 2002 18:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJAWTz>; Tue, 1 Oct 2002 18:19:55 -0400
Received: from [195.39.17.254] ([195.39.17.254]:18180 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262866AbSJAWS1>;
	Tue, 1 Oct 2002 18:18:27 -0400
Date: Mon, 30 Sep 2002 07:45:20 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020930074519.B159@toy.ucw.cz>
References: <20020925172024.GH15479@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020925172024.GH15479@suse.de>; from axboe@suse.de on Wed, Sep 25, 2002 at 07:20:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Due to recent "problems" (well the vm being just too damn good at keep
> disks busy these days), it's become even more apparent that our current
> io scheduler just cannot cope with some work loads. Repeated starvartion
> of reads is the most important one. The Andrew Morton Interactive
> Workload (AMIW) [1] rates the current kernel poorly, on my test machine
> it completes in 1-2 minutes depending on your luck. 2.5.38-BK does a lot
> better, but mainly because it's being extremely unfair. This deadline io
> scheduler finishes the AMIW in anywhere from ~0.5 seconds to ~3-4
> seconds, depending on the io load.

would it be possible to make deadlines per-process to introduce ionice?

ionice -n -5 mpg123 foo.mp3
ionice make

?								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

