Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRDWULJ>; Mon, 23 Apr 2001 16:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDWULA>; Mon, 23 Apr 2001 16:11:00 -0400
Received: from [194.46.8.33] ([194.46.8.33]:43026 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S129282AbRDWUKv>;
	Mon, 23 Apr 2001 16:10:51 -0400
Date: Mon, 23 Apr 2001 21:12:38 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
Message-ID: <20010423211237.I26083@vnl.com>
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> <01042121404701.08246@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <01042121404701.08246@antares>; from s-jaschke@t-online.de on Sat, Apr 21, 2001 at 09:40:47PM +0200
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Talk about syncronicity... I had just last week asked
about the pro's and con's on this on the crypto list and
have heard nothing at all back. So I'll drop the body
of that message in here:

--
I've got a crypto loopback running directly on a /dev/md0
partition and then the file system on top of that. I'm
interested in what the feelings of others are on the
trade offs of doing it this way.

Is there something to be gained by adding a file system
layer between the /dev/md0 and the loopback file as far
as error recovery is concerned?

Do I actually gain performance (as I am guessing currently
that I do) by eliminating one layer?

It's just a plaything right now, but I'd be interested
in some feedback on the wisdom of it before I actually
use this on something important. So just to reiterated:

                               fs
          fs                c. loopback
        c. loopback  vs        fs
         raid1                raid1
        disk disk           disk disk

where fs = ext2 until this evening when I replace it
with reiserfs.
--

And update by saying I've got reiserfs working on top
of it with no problems. But I'm still just that wee
bit nervous about the approach even though it works.

What happens if I get one bad disk sector in a partition?
What is the difference in data loss between encrypting
on the bare partition versus having say, a reiserfs
under you?

(Obviously RAID doesn't save you. It will just merrily
reproduce the bad sector on the mirror disk)

-- 
------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------
