Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S145008AbRA2DBj>; Sun, 28 Jan 2001 22:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S145042AbRA2DBT>; Sun, 28 Jan 2001 22:01:19 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:26154 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S145008AbRA2DBO>; Sun, 28 Jan 2001 22:01:14 -0500
Message-ID: <3A74DCEE.7FBC1879@linux.com>
Date: Sun, 28 Jan 2001 19:01:02 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: D state after applying ps hang patch
In-Reply-To: <3A74B6AE.C179050B@linux.com> <20010129013145.G12772@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The one LInus posted plus his addendum for the ll_rw_blk.
http://blue-labs.org/patches/ps-hang.patch

-d

Jens Axboe wrote:

> On Mon, Jan 29 2001, David Ford wrote:
> > kernel 2.4.0-ac12
> >
> > # ps -eo user,pid,args,wchan|egrep "imap|update|procmail"
> > root         7 [kupdate]        get_request_wait
> > david      627 imapd            get_request_wait
> > david      752 procmail -f linu down
> > david      761 procmail -f linu down
> > david      799 procmail -f linu down
> > david      854 procmail -f linu down
> > david      886 procmail -f linu down
> > david      847 imapd            get_request_wait
> > david     1079 procmail -f linu down
> > david     3280 imapd            interruptible_sleep_on_locked
> > david     3321 imapd            interruptible_sleep_on_locked
> >
> > and the cpu load is artificially inflated to 9.17
>
> Which patch specifically?

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
