Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281663AbRLUNXJ>; Fri, 21 Dec 2001 08:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRLUNXA>; Fri, 21 Dec 2001 08:23:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31763 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281663AbRLUNWv>;
	Fri, 21 Dec 2001 08:22:51 -0500
Date: Fri, 21 Dec 2001 14:21:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sr: unaligned transfer
Message-ID: <20011221142133.C811@suse.de>
In-Reply-To: <m16HOib-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m16HOib-0005khC@gherkin.frus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, Bob_Tracy wrote:
> Anyone else seeing this?  With kernel version 2.5.1, I get several
> instances of 
> 
> 	sr: unaligned transfer
> 
> followed by
> 
> 	Unable to identify CD-ROM format.
> 
> whenever I try to mount a CD-ROM.  This is something new with 2.5.1
> (probably the new bio code), as all prior kernel versions (non-pre)
> work fine.  SCSI driver is aic7xxx.

What fs? Older sr padded front and back of request to correctly align
it, but I removed that code. Please try and mount with -o loop instead.

-- 
Jens Axboe

