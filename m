Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRK2Th4>; Thu, 29 Nov 2001 14:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280883AbRK2Thr>; Thu, 29 Nov 2001 14:37:47 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:934 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280766AbRK2Th2>; Thu, 29 Nov 2001 14:37:28 -0500
Date: Thu, 29 Nov 2001 20:36:45 +0100
From: Dirk Pritsch <dirk@enterprise.in-berlin.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.5.1-pre3 in ide-scsi module
Message-ID: <20011129203645.A499@Enterprise.in-berlin.de>
In-Reply-To: <20011129191938.A1402@Enterprise.in-berlin.de> <20011129193956.S10601@suse.de> <20011129194752.T10601@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129194752.T10601@suse.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 29, 2001 at 07:47:52PM +0100, Jens Axboe wrote:
> On Thu, Nov 29 2001, Jens Axboe wrote:
> > Hmm, I bet the problem is not really bio but the fact that someone is
> > still sending down a scatterlist with ->address set instead of
> > ->page/offset.
> > 
> > Let me hack a quick fix up for you to test... 2 minutes.
> 
> Please try this, and check for oops and "jens was right" in dmesg. Let
> me know how it goes, thanks.
> 
> 
Ok, applied the diff from Alan, and the two I got from you, and it seems
to work (burning still in progress).

Instead of an oops, syslog now tells me:

Nov 29 20:32:49 enterprise kernel: jens was right

when loading the modules.



Thanks for the quick fix,

Cheers,

Dirk

