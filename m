Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbREXOi1>; Thu, 24 May 2001 10:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbREXOiR>; Thu, 24 May 2001 10:38:17 -0400
Received: from waste.org ([209.173.204.2]:34111 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262052AbREXOiD>;
	Thu, 24 May 2001 10:38:03 -0400
Date: Thu, 24 May 2001 09:39:35 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Marko Kreen <marko@l-t.ee>
cc: Edgar Toernig <froese@gmx.de>, Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device
 arguments from lookup)
In-Reply-To: <20010524094717.A23722@l-t.ee>
Message-ID: <Pine.LNX.4.30.0105240937490.16271-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Marko Kreen wrote:

> On Thu, May 24, 2001 at 02:23:27AM +0200, Edgar Toernig wrote:
> > Daniel Phillips wrote:
> > > > > It's going to be marked 'd', it's a directory, not a file.
> > > >
> > > > Aha.  So you lose the S_ISCHR/BLK attribute.
> > >
> > > Readdir fills in a directory type, so ls sees it as a directory and does
> > > the right thing.  On the other hand, we know we're on a device
> > > filesystem so we will next open the name as a regular file, and find
> > > ISCHR or ISBLK: good.
> >
> > ??? The kernel may know it, but the app?  Or do you really want to
> > give different stat data on stat(2) and fstat(2)?  These flags are
> > currently used by archive/backup prgs.  It's a hint that these files
> > are not regular files and shouldn't be opened for reading.
> > Having a 'd' would mean that they would really try to enter the
> > directory and save it's contents.  Don't know what happens in this
> > case to your "special" files ;-)
>
> IMHO the CHR/BLK is not needed.  Think of /proc.  In the future,
> the backup tools will be told to ignore /dev, that's all.

The /dev dir should not be special. At least not to the kernel. I have
device files in places other than /dev, and you probably do too (hint:
anonymous FTP).

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

