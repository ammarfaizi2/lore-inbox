Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263445AbREXJVY>; Thu, 24 May 2001 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbREXJVP>; Thu, 24 May 2001 05:21:15 -0400
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:14526 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S263437AbREXJVC>;
	Thu, 24 May 2001 05:21:02 -0400
Date: Thu, 24 May 2001 10:20:58 +0100
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD  w/info-PATCH]device arguments from lookup)
Message-ID: <20010524102058.B1249@sable.ox.ac.uk>
In-Reply-To: <3B0717CE.57613D4A@mandrakesoft.com> <200105221853.f4MIroHt011398@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105221853.f4MIroHt011398@webber.adilger.int>; from adilger@turbolinux.com on Tue, May 22, 2001 at 12:53:50PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list reduced]

Andreas Dilger writes:
> PS - I used to think shrinking a filesystem online was useful, but there
>      are a huge amount of problems with this and very few real-life
>      benefits, as long as you can at least do offline shrinking.  With
>      proper LVM usage, the need to shrink a filesystem never really
>      happens in practise, unlike the partition case where you always
>      have to guess in advance how big a filesystem needs to be, and then
>      add 10% for a safety margin.  With LVM you just create the minimal
>      sized device you need now, and freely grow it in the future.

In an attempt to nudge you back towards your previous opinion: consider
a system-wide spool or tmp filesystem. It would be nice to be able to
add in a few extra volumes for a busy period but then shrink it down
again when usage returns to normal. In the absence of the ability to
shrink a live filesystem, storage management becomes a much harder job.
You can't throw in a spare volume or two where it's needed without
careful thought because you'll be ratchetting up the space on that one
filesystem without being able to change your mind and reduce it again
later. You'll end up with stingy storage admins who refuse to give you
a bunch of extra filesystem space for a while because they can't get it
back again afterwards.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
