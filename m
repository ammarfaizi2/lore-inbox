Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRI1DlT>; Thu, 27 Sep 2001 23:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275820AbRI1DlB>; Thu, 27 Sep 2001 23:41:01 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4386 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275816AbRI1Dk5>; Thu, 27 Sep 2001 23:40:57 -0400
Date: Thu, 27 Sep 2001 23:40:23 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
Message-ID: <20010927234023.A16753@devserv.devel.redhat.com>
In-Reply-To: <200109042234.AAA28635@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109042234.AAA28635@harpo.it.uu.se>; from mikpe@csd.uu.se on Wed, Sep 05, 2001 at 12:34:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 5 Sep 2001 00:34:57 +0200 (MET DST)
> From: Mikael Pettersson <mikpe@csd.uu.se>
> To: zaitcev@redhat.com
> Cc: Floydsmith@aol.com, linux-kernel@vger.kernel.org,
>    linux-tape@vger.kernel.org

> >> - block size: The 2.4 ide-tape driver only works reliably if you
> >>   write data with the correct block size. If you don't write full
> >>   blocks the last block of data may not be readable.
> >
> >I fixed that some time ago, it's in current -ac
> >if not in Linus's tree.
> 
> Sorry, but that's not correct. I just ran a test, and the bug is
> still there in 2.4.9-ac7. Maybe you're thinking of some other bug?

OK, perhaps you are right. I received a credible report from
Ed Tomlinson that the "reading the last block" bug is in 2.4.10.

It seems that either I fixed something else with the same symptoms
or I fixed it improperly. Unfortunately, I cannot reproduce it.

By the way, why does everyone insist on using ide-tape?
It seems to be broken beyond any repair by injection of
lethal poison marked "OnStream Support" (not that it was brilliant
before, but that was the last nail in the coffin). Just use ide-scsi
and be done with it. I really do not enjoy reading ide-tape.c.

-- Pete
