Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265915AbRGOFrq>; Sun, 15 Jul 2001 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbRGOFrh>; Sun, 15 Jul 2001 01:47:37 -0400
Received: from geos.coastside.net ([207.213.212.4]:24821 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S265641AbRGOFrX>; Sun, 15 Jul 2001 01:47:23 -0400
Mime-Version: 1.0
Message-Id: <p05100313b776de2f4b7e@[207.213.214.37]>
In-Reply-To: <20010715160247.I7624@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
 <p05100307b7762dc5d8ad@[207.213.214.37]>
 <20010715160247.I7624@weta.f00f.org>
Date: Sat, 14 Jul 2001 22:46:20 -0700
To: Chris Wedgwood <cw@f00f.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:02 PM +1200 2001-07-15, Chris Wedgwood wrote:
>On Sat, Jul 14, 2001 at 10:33:44AM -0700, Jonathan Lundell wrote:
>
>     What's worse, though the spec is not explicit on this point, it
>     appears that the write cache is lost on a SCSI reset, which is
>     typically used by drivers for last-resort error recovery. And of
>     course a SCSI bus reset affects all the drives on the bus, not
>     just the offending one.
>
>Doesn't SCSI have a notion of write barriers?
>
>Even if this is required, the above still works because for anything
>requiring a barrier, you wait for a positive SYNCHRONIZE CACHE

Sure, if you keep all your write buffers around until then, so you 
can re-write if the sync fails. And if you don't crash in the 
meantime.
-- 
/Jonathan Lundell.
