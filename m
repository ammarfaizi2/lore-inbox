Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbTGTKMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbTGTKMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:12:07 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:31922 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266799AbTGTKMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:12:03 -0400
Date: Sun, 20 Jul 2003 12:26:53 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to use "ATAPI:" protocol for IDE CD/RWs??
Message-ID: <20030720122653.C22265@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain>; from rpjday@mindspring.com on Sun, Jul 20, 2003 at 06:08:30AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   are there known problems with trying to access IDE CD/RWs directly
> through the IDE drivers, rather than using SCSI emulation?  i've tried
> testing cdrecord using the "dev=ATAPI:x,y,z" option, and am having
> no luck.

Take a look at
http://www.codemonkey.org.uk/post-halloween-2.5.txt

Excerpt:

CD Recording.
~~~~~~~~~~~~
- Jens Axboe added the ability to use DMA for writing CDs on
  ATAPI devices. Writing CDs should be much faster than it
  was in 2.4, and also less prone to buffer underruns and the like.
- Updated cdrecord in rpm and tar.gz can be found at
  *.kernel.org/pub/linux/kernel/people/axboe/tools/
- With the above tools, you also no longer need ide-scsi in order to use
  an IDE CD writer.
- Ripping audio tracks off of CDs now also uses DMA and should be
  notably faster. You can also find an updated cdda2wav at the same location.
- Send good/bad reports of audio extraction with cdda2wav and burning with
  the modified cdrecord to Jens Axboe <axboe@suse.de>
- Currently only 'open by device name' works in cdrecord.
  cdrecord -dev=/dev/hdX -inq
- More info at http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/

Rudo.
