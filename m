Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDRK4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDRK4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 06:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWDRK4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 06:56:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52120 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932078AbWDRK4T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 06:56:19 -0400
Subject: Re: ide-cd.c, "MEDIUM_ERROR" handling
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zinx Verituse <zinx@epicsol.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <20060418011839.GA10619@atlantis.chaos>
References: <20060418011839.GA10619@atlantis.chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 12:04:40 +0100
Message-Id: <1145358280.18736.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-17 at 20:18 -0500, Zinx Verituse wrote:
> I recently bought a DVD drive which appears to not retry enough when it's
> having trouble reading a disc 

Different to everything else I've ever met. You might want to check if
its got PC firmware or is actually from a set of drives that were meant
to be supplied in DVD players and similar.

> With this code enabled, no retries are made, and the kernel sees medium errors
> and returns bad data to the application reading; without it, the kernel retries
> transparently and reads the data perfectly.  So, I think the comment is
> assuming decent hardware, which unfortunately isn't always what we have :/

Use ide-scsi or the new libata drivers, either will do retries on medium
errors.

Alan
