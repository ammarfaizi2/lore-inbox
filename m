Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266631AbRGOOuO>; Sun, 15 Jul 2001 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266629AbRGOOuF>; Sun, 15 Jul 2001 10:50:05 -0400
Received: from weta.f00f.org ([203.167.249.89]:1924 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266618AbRGOOt6>;
	Sun, 15 Jul 2001 10:49:58 -0400
Date: Mon, 16 Jul 2001 02:50:02 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Ken Hirsch <kenhirsch@myself.com>
Cc: John Alvord <jalvo@mbay.net>, Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716025002.B10576@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.20.0107142304010.17541-100000@otter.mbay.net> <20010715180752.B7993@weta.f00f.org> <005501c10d30$54e0e260$7c853dd0@hppav>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005501c10d30$54e0e260$7c853dd0@hppav>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 09:16:09AM -0400, Ken Hirsch wrote:

    The first technique is not sufficient with modern disk
    controllers, which may reorder sector writes within a block.  A
    checksum, especially a robust CRC32, is sufficient, but rather
    expensive.

So you write the number to the start and end of each sector, or, you
only assume sector-wide 'block-sizes' for integrity.

A 32-bit CRC is plenty cheap enough on modern CPUs and especially
considering how often you need to calculate it.

    Mohan has a clever technique that is computationally trivial and
    only uses one bit per sector:
    http://www.almaden.ibm.com/u/mohan/ICDE95.pdf
    
    Unfortunately, it's also patented:
    http://www.delphion.com/details?pn=US05418940__
    
    Perhaps IBM will clarify their position with respect to free
    software and patents in the upcoming conference.

Wow... pretty neat, but fortunately not necessary.



  --cw
