Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbRBMASh>; Mon, 12 Feb 2001 19:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBMASR>; Mon, 12 Feb 2001 19:18:17 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:40206 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129700AbRBMASM>; Mon, 12 Feb 2001 19:18:12 -0500
Date: Mon, 12 Feb 2001 19:18:05 -0500
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>,
        Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <415160000.982023485@tiny>
In-Reply-To: <3A886606.E3557ED3@namesys.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, February 13, 2001 01:39:02 AM +0300 Hans Reiser
<reiser@namesys.com> wrote:
> Chris, your quoting is very confusing above..... but I get your very
> interesting remark (thanks for noticing) that the nulls are specific to
> crashes on 2.2, and therefor could be due to the elevator bug on 2.4.  It
> even makes rough sense that the elevator bug (said to occasionally cause
> a premature write of the wrong buffer) could cause an effect similar to a
> crash.  I hope it is true, let's ask all users to upgrade to pre2 (a good
> idea anyway) and see if it cures.
> 

Ok, I'll try again ;-)  People have been seeing null bytes in data files on
reiserfs.  They see this without seeing any other corruption of any kind,
and they only see it on files of very specific sizes.  They see this
without crashing, and without hard drive suspend kicking in.  They see it
on scsi and ide, on servers and laptops.

Elevator bugs and general driver bugs could certainly cause nulls in data
files.  But they would also cause other corruptions and probably would not
be selective enough to pick files that happen to have the same range in
size that reiserfs packs tails on.

In other words, updating to 2.4.2pre2 or your favorite ac series kernel is
probably a good plan.  It won't fix this bug ;-)

Perhaps I haven't seen it yet because I've also been testing code that does
direct->indirect conversions slightly differently, I'll try again on a pure
kernel.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
