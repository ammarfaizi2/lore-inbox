Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSDFAIC>; Fri, 5 Apr 2002 19:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313300AbSDFAHw>; Fri, 5 Apr 2002 19:07:52 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:31203 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313070AbSDFAHk>; Fri, 5 Apr 2002 19:07:40 -0500
Message-Id: <200204060007.g3607I525699@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: faster boots?
Date: Sat, 6 Apr 2002 03:07:05 +0300
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204052302.g35N2o516910@lmail.actcom.co.il> <20020405180735.E15540@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 April 2002 02:07 am, Benjamin LaHaise wrote:
> On Sat, Apr 06, 2002 at 02:02:36AM +0300, Itai Nahshon wrote:
> > A required feature IMHO: there should _never_ be dirty blocks
> > for disks that are not spinning.
>
> Never make assertions like that: on my laptop, I want *lots* of
> dirty blocks held in memory while the disk isn't spinning.  Keeping
> RAM powered is much less costly than spinning the disk up.
>
> 		-ben

I figure that if there are dirty blocks that belong to files that you
want to keep, they must be flushed at some time, probably on the
next sync(). On "normal" systems that's likely to happen in less
than a minute.

I admit that what I had in mind was medium-large systems with
multiple disks where some of the disks have very little activity
or small systems where there is really zero disk activity for
a long time.

I'm curios, how much work can you accomplish on your laptop
without any disk access (but you still need to save files - keeping
them in buffers until it's time to actually write them).

-- Itai

