Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143815AbRAHNjH>; Mon, 8 Jan 2001 08:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143790AbRAHNi0>; Mon, 8 Jan 2001 08:38:26 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:6092 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S143740AbRAHNiO>; Mon, 8 Jan 2001 08:38:14 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Patch (repost): cramfs memory corruption fix
Date: Mon, 8 Jan 2001 12:30:58 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com> <23514.978959516@redhat.com>
In-Reply-To: <23514.978959516@redhat.com>
MIME-Version: 1.0
Message-Id: <01010812305810.02165@www.easysolutions.net>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 January 2001 13:11, David Woodhouse wrote:
> torvalds@transmeta.com said:
> >  Also, if you care about memory usage, you're likely to be much better
> > off using ramfs rather than something like "ext2 on ramdisk". You
> > won't get the double buffering.
>
> That'll be even more useful once we can completely configure out all
> support for block devices too.
>

While the topic is raised..., I've hacked up cramfs for linear addressing to 
kill the "double buffering" effiect.  However as David mentions the block 
device support thing is an issue here.  What is a reasonable way to allow a 
cramfs partition to access the device directly, like the patch that I wrote, 
and be picked up in a reasonable way by the init system?

(Current system does some non-cool things like find out it's cramfs from 
/dev/rom <also a patch>, and within cramfs never accesses that block device 
anymore..., it's sort of silly, and _not_ the right way to do it.)

Thanks,
Shane Nay.
(Patches referenced here can be found at: 
ftp://ftp.agendacomputing.com/pub/agenda/testing/CES/patches/ , contributed 
by various authors: Rob Leslie, Brad Laronde, and myself.  If you want the 
mkcramfs with xip, just ask.)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
