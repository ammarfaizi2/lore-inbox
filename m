Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSGCWH6>; Wed, 3 Jul 2002 18:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSGCWH5>; Wed, 3 Jul 2002 18:07:57 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40456
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317263AbSGCWH5>; Wed, 3 Jul 2002 18:07:57 -0400
Date: Wed, 3 Jul 2002 15:09:15 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Eduard Bloch <edi@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
In-Reply-To: <200207032018.g63KIis03950@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.10.10207031500390.19028-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OIC, then it is clear that SCSI can deal with DSC overlap and granting
bandwidth to the other device on the chain which is not ATAPI.
Sorry Pete, but this is the typical mind set of people who do not
understand all the specification from the past that current hardware is
bound to.  Gadi was very clever in making DSC work.  I understand the
principles but seriously doubt I could have derived what Gadi did.



Cheers,


On Wed, 3 Jul 2002, Pete Zaitcev wrote:

> >[...]
> > To be honest - why keep ide-[cd,floppy,tape] when they can be almost
> > completely replaced with ide-scsi?
> 
> James Bottomley was going to take care of this, so I did not
> even bother with ide-tape cleanups in 2.5. Good riddance for
> that crap.
> 
> Note though, ide-tape is not anywhere near semantically
> to the ide-scsi+st, because of its "sophisticated" (e.g. utterly
> broken) internal pipeline. It does a lot of work underneath
> the /dev boundary. Apparently, the author had a bad case of streaming
> stoppages on his 386, so instead of fixing the root cause he
> wrote the monster we have today. Getting rid of ide-tape may
> cause problems on 386's. But then again, perhaps not.
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

