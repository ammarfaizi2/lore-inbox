Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282981AbRK0WKi>; Tue, 27 Nov 2001 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRK0WK2>; Tue, 27 Nov 2001 17:10:28 -0500
Received: from ns.caldera.de ([212.34.180.1]:25557 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282981AbRK0WKI>;
	Tue, 27 Nov 2001 17:10:08 -0500
Date: Tue, 27 Nov 2001 23:09:55 +0100
Message-Id: <200111272209.fARM9tk18991@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <9u0ua1$1g2$1@penguin.transmeta.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9u0ua1$1g2$1@penguin.transmeta.com> you wrote:
> In many cases the fix is as simple as just replacing the
> "io_request_lock" with "host->host_lock", but sometimes this is
> complicated by the need to pass the right data structures down far
> enough..
>
> Many drivers have been converted (ie IDE, symbios, aic7xxx etc), but
> many more have not (especially older SCSI drivers, in your case it's the
> classic aha1542).
>
> It will probably take some time until most drivers have been converted.
> Tested patches are more than welcome,

While we are at breaking scsi, would you take a patch to remove the
old-style (2.0) scsi error handling completly, forcing drivers still
using it to be fixed?  Early 2.5 looks like a good time for that to me..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
