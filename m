Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292659AbSCDSUE>; Mon, 4 Mar 2002 13:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292657AbSCDST6>; Mon, 4 Mar 2002 13:19:58 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:45718 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292654AbSCDSTn>;
	Mon, 4 Mar 2002 13:19:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Mon, 4 Mar 2002 19:15:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com>
In-Reply-To: <20020304165216.A1444@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hwzT-0000et-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 05:52 pm, Stephen C. Tweedie wrote:
> Hi,
> 
> On Sun, Mar 03, 2002 at 10:09:35PM -0800, Jeremy Higdon wrote:
> 
> > > WCE is per-command?  And 0 means no caching, so the command must complete
> > > when the data is on the media?
> > 
> > My reading is that WCE==1 means that the command is complete when the
> > data is in the drive buffer.
> 
> Even if WCE is enabled in the caching mode page, we can still set FUA
> (Force Unit Access) in individual write commands to force platter
> completion before commands complete.

Yes, I discovered the FUA bit just after making the previous post, so please
substitute 'FUA' for 'WCE' in the above.

> Of course, it's a good question whether this is honoured properly on
> all drives.
> 
> FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.

I'm having a little trouble seeing the difference between WRITE10, WRITE12
and WRITE16.  WRITE6 seems to be different only in not garaunteeing to 
support the FUA (and one other) bit.  I'm reading the Scsi Block Commands
2 pdf:

   ftp://ftp.t10.org/t10/drafts/sbc2/sbc2r05a.pdf

(Side note: how nice it would be if t10.org got a clue and posted their
docs in html, in addition to the inconvenient, unhyperlinked, proprietary
format pdfs.)

-- 
Daniel
