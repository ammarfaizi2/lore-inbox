Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUC2Mci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUC2McV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:32:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45455 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262907AbUC2MaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:30:16 -0500
Date: Mon, 29 Mar 2004 13:42:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329114210.GF1453@openzaurus.ucw.cz>
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <200403280032.22180.bzolnier@elka.pw.edu.pl> <40660FEC.8080703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40660FEC.8080703@pobox.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What about latency?
...
> merged transfer will top out at 8MB.  You don't see that unless 
> you're on a totally quiet machine with tons of free, contiguous 
> pages.  So in practice it winds up being much smaller, the more 
> loaded the system gets (and pagecache gets fragmented).
> 
> Latency definitely changes for the default case, but remember that a 
> lot of that is writeback, or streaming writes.  Latency-sensitive 
> applications already know how to send small or no-wait I/Os, because 

Well, waiting second for read because 32MB write is being done
will not be fun...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

