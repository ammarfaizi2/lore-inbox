Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130302AbRBCBrx>; Fri, 2 Feb 2001 20:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130843AbRBCBrn>; Fri, 2 Feb 2001 20:47:43 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:64774 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S130302AbRBCBre>;
	Fri, 2 Feb 2001 20:47:34 -0500
Message-ID: <3A7B63D1.2588963B@megapathdsl.net>
Date: Fri, 02 Feb 2001 17:50:09 -0800
From: Miles Lane <miles@megapathdsl.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: newsreader@mediaone.net, linux-kernel@vger.kernel.org
Subject: Re: did 2.4 messed up lilo?
In-Reply-To: <786060000.981147343@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Friday, February 02, 2001 03:36:18 PM -0500 newsreader@mediaone.net
> wrote:
> 
> > I'm not sure whether this problem is related
> > to 2.4 kernel.
> >
> 
> I suspect it is a reiserfs problem, and that you are using lilo older than
> 21.6.  Are you mounting /boot with -o notail?
> 
> Regardless, I'm willing to bet upgrading to lilo 21.6 will solve this.  It
> calls an ioctl reiserfs provides to unpack small files, and I've seen it
> fix this exact problem on one of my devel boxes (no lilo prompt, append
> lines in lilo.conf ignored).

I also found this patch for lilo 21.6:


http://industrial-linux.org/distro/download/lilo-21.6-glibc-2.2-reiserfs.patch

Perhaps someone familiar with the lilo and reiserfs code could explain 
whether or not this patch is really needed.

	Miles
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
