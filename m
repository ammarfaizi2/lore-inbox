Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbREXHpY>; Thu, 24 May 2001 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbREXHpO>; Thu, 24 May 2001 03:45:14 -0400
Received: from www.inreko.ee ([195.222.18.2]:22761 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S263400AbREXHo4>;
	Thu, 24 May 2001 03:44:56 -0400
Date: Thu, 24 May 2001 09:47:17 +0200
From: Marko Kreen <marko@l-t.ee>
To: Edgar Toernig <froese@gmx.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Message-ID: <20010524094717.A23722@l-t.ee>
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105221851200C.06233@starship> <3B0B3A4C.FD7143F9@gmx.de> <0105231550390K.06233@starship> <3B0C547F.DE9E9214@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0C547F.DE9E9214@gmx.de>; from froese@gmx.de on Thu, May 24, 2001 at 02:23:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 02:23:27AM +0200, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > > > It's going to be marked 'd', it's a directory, not a file.
> > >
> > > Aha.  So you lose the S_ISCHR/BLK attribute.
> > 
> > Readdir fills in a directory type, so ls sees it as a directory and does
> > the right thing.  On the other hand, we know we're on a device
> > filesystem so we will next open the name as a regular file, and find
> > ISCHR or ISBLK: good.
> 
> ??? The kernel may know it, but the app?  Or do you really want to
> give different stat data on stat(2) and fstat(2)?  These flags are
> currently used by archive/backup prgs.  It's a hint that these files
> are not regular files and shouldn't be opened for reading.
> Having a 'd' would mean that they would really try to enter the
> directory and save it's contents.  Don't know what happens in this
> case to your "special" files ;-)

IMHO the CHR/BLK is not needed.  Think of /proc.  In the future,
the backup tools will be told to ignore /dev, that's all.

-- 
marko

