Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312140AbSCQX7P>; Sun, 17 Mar 2002 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312144AbSCQX7G>; Sun, 17 Mar 2002 18:59:06 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:4778 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312140AbSCQX64>;
	Sun, 17 Mar 2002 18:58:56 -0500
Message-Id: <5.1.0.14.2.20020317235532.051d0cc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Mar 2002 23:59:03 +0000
To: Joel Becker <jlbec@evilplan.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20020317192028.U4836@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
 <3C945635.4050101@mandrakesoft.com>
 <3C945A5A.9673053F@zip.com.au>
 <3C945D7D.8040703@mandrakesoft.com>
 <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:20 17/03/02, Joel Becker wrote:
>On Sun, Mar 17, 2002 at 01:41:37PM +0000, Anton Altaparmakov wrote:
> > When you want large data streaming, i.e. you start getting worried about
> > memory pressure, then you want open(2) + O_DIRECT. No caching done. 
> Perfect
> > for large data streams and we have that already. I agree that you may want
> > some form of asynchronous read ahead with passed pages being dropped from
> > the cache but that could be just a open(2) + O_SEQUENTIAL (doesn't 
> exist yet).
>
>         O_DIRECT isn't the right thing for large streaming.  You want
>readahead and dropbehind.  O_DIRECT takes substantial penalties for its
>lack of copy/cacheing.  This works fine in certain circumstances
>(applications that keep their own caching), but for something like a
>video or mp3, you'll win with working dropbehind easily.

Oh absolutely. For mp3s, dvds, etc. Note I wrote O_SEQUENTIAL... Perhaps I 
didn't emphasize it enough. In multimedia applications you very well know 
in advance what you want so you can specify it at open(2) time.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

