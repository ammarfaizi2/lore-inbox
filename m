Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265965AbRF1ONP>; Thu, 28 Jun 2001 10:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265959AbRF1ONG>; Thu, 28 Jun 2001 10:13:06 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:49654 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265941AbRF1OMu>; Thu, 28 Jun 2001 10:12:50 -0400
Message-ID: <3B3B3B63.739554CA@uow.edu.au>
Date: Fri, 29 Jun 2001 00:12:51 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        raid <linux-raid@vger.kernel.org>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: 2.2.6-pre6 ext3 Part II
In-Reply-To: <02bd01c0ffcf$6a85f150$e1de11cc@csihq.com> <3B3B291A.3DFDA2A4@uow.edu.au> <032f01c0ffd9$8bfc2e80$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> Trying to recover from ext3 journal failure....swtiched drive back to ext2

Could we please have more details on the "journal failure"?

> Now my fiber channel driver is complaining:
> qlogicfc0: no handle slots, this should not happen.
> hostdata->queue  is 2a, inptr: 74
> And a bunch more (77,79,7b,7d,7e) after which it locks up completely.
> 
> This is while the raid5 is resyncing and it's trying to do an e2fsck at the
> same time.
> 
> I'm now going to try letting the resync complete before doing the e2fsck.
> 
> Looks like I'm just running into cascading problems here...sigh...
> 

I'd suggest you fix one problem at a time: get the driver
and raid working solidly with ext2, then try ext3.

-
