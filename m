Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRKVQbA>; Thu, 22 Nov 2001 11:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280012AbRKVQav>; Thu, 22 Nov 2001 11:30:51 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47613 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280002AbRKVQak>;
	Thu, 22 Nov 2001 11:30:40 -0500
Date: Thu, 22 Nov 2001 09:30:32 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Cc: S.Akhtary@TeraPort.de, mjustice@boxxtech.com
Subject: Re: Tuning Linux for high-speed disk subsystems
Message-ID: <20011122093032.H1308@lynx.no>
Mail-Followup-To: linux-kernel@vger.kernel.org, S.Akhtary@TeraPort.de,
	mjustice@boxxtech.com
In-Reply-To: <3BFCD029.DAED8BF7@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFCD029.DAED8BF7@TeraPort.de>; from Martin.Knoblauch@TeraPort.de on Thu, Nov 22, 2001 at 11:15:05AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Tuning Linux for high-speed disk subsystems
> > As I count your disks may be the double for the best case. I read here on
> > LKML a post that someone claims that W2k deliever 250 MB/s with such a
> > configuration. Linux 2.4 should do the same. Ask the SCSI gurus.
> 
> That may have been my post you refer to. With 2x5 disks, each capable of
> 50 MB/s by itself, we can stream 255 MB/s very smoothly in either direction
> with W2K --- as long as FILE_FLAG_NOBUFFER is used. With standard
> reads the number is more like 100 MB/s if I recall correctly, so the buffer
> cache can definitely get in the way.
> 
> With Linux + XFS I was getting 250 MB/s read and 220 MB/s write (with a
> bit less smoothness than W2K) using O_DIRECT and no high mem to avoid
> bounce buffer copies. Using standard reads the numbers drop to around
> 120 MB/s. That was a couple of weeks ago and I want to try tweaking some
> more but a co-worker has "borrowed" pieces of the hardware for the moment.

Jusy FYI, Linus announced that he had returned Andrea's O_DIRECT support
to the most recent 2.4.15-pre kernel, so you are no longer restricted to
using XFS for no-cache I/O.  Whether you will be able to beat XFS for
speed using any other filesystem is another question.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

