Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGWH2>; Wed, 7 Feb 2001 17:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129110AbRBGWHT>; Wed, 7 Feb 2001 17:07:19 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43281 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129032AbRBGWHK>; Wed, 7 Feb 2001 17:07:10 -0500
Message-ID: <3A81C6BF.D892CFE6@baldauf.org>
Date: Wed, 07 Feb 2001 23:05:51 +0100
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Chris Wedgwood <cw@f00f.org>, Xuan Baldauf <xuan--reiserfs@baldauf.org>,
        David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <707700000.981582926@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

> On Thursday, February 08, 2001 10:47:29 AM +1300 Chris Wedgwood
> <cw@f00f.org> wrote:
>
> > these appear on your system every couple of days right? if so... are
> > you able to run with the fs mount notails for a couple of days and
> > see if you still experience these?
> >
> > my guess is you probably still will as most log files aren't
> > candidates for tail-packing (too large) but it will help eliminate
> > one more thing....
> >
>
> Yes, it really would.
>
> 1) mount -o notail
> 2) rm old_logfile
> 3) restart syslog
>
> This will ensure the log files don't have tails at all.  Knowing for sure
> the bug doesn't involve tails would remove much code from the search.
>
> -chris

Mhhh. It's a busy server from which I am about 700km away. I don't like to
restart it now. (Especially because it cannot boot from hard disk, only from
floppy disk, due to bios problems). But I'd be happy if following is true:

(1) Enabling "-o notails" is possible at runtime, i.e. "mount / -o
remount,notails" works and
(2) Notails is compatible with all the tails found on disk (so notails only
changes the way the disk is written, not the way the disk is read).

Is this true?

Xuân.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
