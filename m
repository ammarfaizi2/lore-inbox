Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313472AbSDHMJj>; Mon, 8 Apr 2002 08:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313473AbSDHMJi>; Mon, 8 Apr 2002 08:09:38 -0400
Received: from 91dyn252.com21.casema.net ([62.234.22.252]:57552 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S313472AbSDHMJf>; Mon, 8 Apr 2002 08:09:35 -0400
Message-Id: <200204081209.OAA12003@cave.bitwizard.nl>
Subject: Re: faster boots?
In-Reply-To: <200204060007.g3607I525699@lmail.actcom.co.il> from Itai Nahshon
 at "Apr 6, 2002 03:07:05 am"
To: Itai Nahshon <nahshon@actcom.co.il>
Date: Mon, 8 Apr 2002 14:09:29 +0200 (MEST)
CC: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Morton <akpm@zip.com.au>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itai Nahshon wrote:
> On Saturday 06 April 2002 02:07 am, Benjamin LaHaise wrote:
> > On Sat, Apr 06, 2002 at 02:02:36AM +0300, Itai Nahshon wrote:
> > > A required feature IMHO: there should _never_ be dirty blocks
> > > for disks that are not spinning.
> >
> > Never make assertions like that: on my laptop, I want *lots* of
> > dirty blocks held in memory while the disk isn't spinning.  Keeping
> > RAM powered is much less costly than spinning the disk up.
> >
> > 		-ben
> 
> I figure that if there are dirty blocks that belong to files that you
> want to keep, they must be flushed at some time, probably on the
> next sync(). On "normal" systems that's likely to happen in less
> than a minute.
> 
> I admit that what I had in mind was medium-large systems with
> multiple disks where some of the disks have very little activity
> or small systems where there is really zero disk activity for
> a long time.
> 
> I'm curios, how much work can you accomplish on your laptop
> without any disk access (but you still need to save files - keeping
> them in buffers until it's time to actually write them).

On a laptop you can decide to "trust" the drive to spin up, just
because the benefits outweigh the drawbacks.

The benefit may be: Battery life becomes 8 hours instead of 4. That
might mean that you get 4 hours of extra work done while travelling at
$100 per hour.... 

Just editing source-code using VI, or reading docs can leave your 
disk completely idle for hours at a time. 

Debugging an app, compiling testing, recompiling can leave your disk
idle provided you accept dirty blocks in the buffer cache...


			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
