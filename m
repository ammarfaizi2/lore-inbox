Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136049AbRD0OdQ>; Fri, 27 Apr 2001 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136050AbRD0OdH>; Fri, 27 Apr 2001 10:33:07 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:22101 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S136049AbRD0OdB>; Fri, 27 Apr 2001 10:33:01 -0400
Date: Fri, 27 Apr 2001 17:32:50 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427173250.G3529@niksula.cs.hut.fi>
In-Reply-To: <20010427095840.A701@suse.cz> <Pine.GSO.4.21.0104270922360.18661-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104270922360.18661-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 27, 2001 at 09:23:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2001 at 09:23:57AM -0400, you [Alexander Viro] claimed:
> 
> 
> On Fri, 27 Apr 2001, Vojtech Pavlik wrote:
> 
> > Actually this is done quite often, even on mounted fs's:
> > 
> > hdparm -t /dev/hda
> 
> You would need either hdparm -t /dev/hda<something> or mounting the
> whole /dev/hda.
> 
> Buffer cache for the disk is unrelated to buffer cache for parititions.

Well, I for one have been running

hdparm -t /dev/md0
or
time head -c 1000m /dev/md0 > /dev/null

while /dev/md0 was mounted without realizing that this could be "stupid" or
that it could eat my data.

/dev/md0 on /backup-versioned type ext2 (rw)

I often cat(1) or head(1) partitions or devices (even mounted ones) if I
need dummy randomish test data for compression or tape drives (that I've
been having trouble with). 

BTW: is 2.2 affected? 2.0? 


-- v --

v@iki.fi
