Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSCDIB4>; Mon, 4 Mar 2002 03:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292150AbSCDIBq>; Mon, 4 Mar 2002 03:01:46 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:15507 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292131AbSCDIB2>;
	Mon, 4 Mar 2002 03:01:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 08:57:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16hl4R-0000Zx-00@starship.berlin> <10203032209.ZM424559@classic.engr.sgi.com>
In-Reply-To: <10203032209.ZM424559@classic.engr.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hnLN-0000aV-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 07:09 am, Jeremy Higdon wrote:
> On Mar 4,  6:31am, Daniel Phillips wrote:
> > On March 4, 2002 05:21 am, Jeremy Higdon wrote:
> > > I have never heard of
> > > any implied requirement to flush to media when a drive receives an
> > > ordered tag and WCE is set.  It does seem like a useful feature to have
> > > in the standard, but I don't think it's there.
> > 
> > It seems to be pretty strongly implied that things should work that way.
> > What is the use of being sure the write with the ordered tag is on media
> > if you're not sure about the writes that were supposedly supposed to
> > precede it?  Spelling this out would indeed be helpful.
> 
> WCE==1 and ordered tag means that the data for previous commands is in
> the drive buffer before the data for the ordered tag is in the drive
> buffer.

Right, and what we're talking about is going further and requiring that WCE=0
and ordered tag means the data for previous commands is *not* in the buffer,
i.e., on the platter, which is the only interpretation that makes sense.

> > > So if one vendor implements those semantics, but the others don't where
> > > does that leave us?
> > 
> > It leaves us with a vendor we want to buy our drives from, if we want our
> > data to be safe.
> 
> The point is, do you write code that depends on one vendor's interpretation?

Yes, that's the idea.  And we need some way of knowing which vendors have
interpreted the scsi spec in the way that maximizes both throughput and
safety.  That's the 'whitelist'.

> If so, then the vendor needs to be identified.  Perhaps other vendors will
> then align themselves.

I'm sure they will.

-- 
Daniel
