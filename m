Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279274AbRKDWXi>; Sun, 4 Nov 2001 17:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279519AbRKDWX1>; Sun, 4 Nov 2001 17:23:27 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:33241 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S279274AbRKDWXK>; Sun, 4 Nov 2001 17:23:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christian Laursen <xi@borderworlds.dk>
Subject: Re: Ext2 directory index, updated
Date: Sun, 4 Nov 2001 23:24:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <m3hesatcgq.fsf@borg.borderworlds.dk>
In-Reply-To: <m3hesatcgq.fsf@borg.borderworlds.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011104222259Z17054-18972+2@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 11:09 pm, Christian Laursen wrote:
> Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> > ***N.B.: still for use on test partitions only.***
> 
> It's the first time, I've tried this patch and I must say, that
> the first impression is very good indeed.
> 
> I took a real world directory (my linux-kernel MH folder containing
> roughly 115000 files) and did a 'du -s' on it.
> 
> Without the patch it took a little more than 20 minutes to complete.
> 
> With the patch, it took less than 20 seconds. (And that was inside uml)
> 
> 
> However, when I accidentally killed the uml, it left me with an unclean
> filesystem which fsck refuses to touch because it has unsupported features.
> 
> Even the latest version does this.
> 
> Is there a patch for fsck, that fixes this somewhere?

Ted Ts'o volunteered to do that but I failed to support him with proper 
documentation so it hasn't been done yet.

However, it's very easy to get around this, just comment out the part of the 
patch that sets the incompat flag.  Then the indexed directories will 
magically turn back into normal directories the next time you write to them 
(it would be very good to give this feature a real-life test :-)

There is an easy way to turn that FEATURE_COMPAT flag back off so you can 
fsck, but I don't know it and I should.

Andreas?

--
Daniel
