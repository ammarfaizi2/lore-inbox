Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291152AbSBLSmM>; Tue, 12 Feb 2002 13:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291160AbSBLSmC>; Tue, 12 Feb 2002 13:42:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17415 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291152AbSBLSlu>; Tue, 12 Feb 2002 13:41:50 -0500
Date: Tue, 12 Feb 2002 13:40:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>, andersen@codepoet.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
In-Reply-To: <E16ae1e-0001ws-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020212133708.6082C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Alan Cox wrote:

> I don't think that should be required actually. The killer on M/O disks
> is seek time, and to an extent rotational latency (its 3 trips round a 
> cheaper M/O disk to rewrite a sector). If anything clustering writes to
> the same track should be a big win.

I believe the impetus to the cluster patch is not to address parformance,
but because without it a media error on the MO causes a system failure.
That seems a good reason to put in the patch, and you can certainly test
it with and without, just be sure to sync() before trying the standard
code ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

