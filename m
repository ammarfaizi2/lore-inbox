Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTAWRxd>; Thu, 23 Jan 2003 12:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbTAWRxc>; Thu, 23 Jan 2003 12:53:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57510 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267039AbTAWRxb>;
	Thu, 23 Jan 2003 12:53:31 -0500
Date: Thu, 23 Jan 2003 19:02:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>, greg@ulima.unil.ch
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123180219.GT910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Joerg Schilling wrote:
> >From greg@ulima.unil.ch Thu Jan 23 18:51:42 2003
> >   7 seconds.  0.98% done, estimate finish Thu Jan 23 18:51:05 2003
> >   6 seconds.  1.22% done, estimate finish Thu Jan 23 18:51:46 2003
> >   5 seconds.  1.46% done, estimate finish Thu Jan 23 18:52:14 2003
> >   0 seconds. Operation starts.
> >Waiting for reader process to fill input buffer ... input buffer ready.
> >BURN-Free is ON.
> >Starting new track at sector: 0
> >Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
> >CDB:  2A 00 00 00 08 B8 00 00 1F 00
> >status: 0x2 (CHECK CONDITION)
> >Sense Bytes:
> >Sense Key: 0xFFFFFFFF [], Segment 0
> >Sense Code: 0x00 Qual 0x00 (no additional sense information) Fru 0x0
> >Sense flags: Blk 0 (not valid) 
> >resid: 63488
> >cmd finished after 0.007s timeout 100s
> 
> 
> In one of my mails, I decribed why there are 2 bugs in the kernel.
> Only one of them so far has been fixed. The sense data is still missing.

That is correct, I'll fix the 2nd bug tomorrow. The new SG_IO transport
is still so new that there are places where I know ide-cd will not do
the right thing wrt sense. In fact I don't think it will every copy
sense back.

-- 
Jens Axboe

