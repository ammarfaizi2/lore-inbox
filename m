Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbRESLbK>; Sat, 19 May 2001 07:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbRESLbB>; Sat, 19 May 2001 07:31:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:35022 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261759AbRESLau>;
	Sat, 19 May 2001 07:30:50 -0400
Date: Sat, 19 May 2001 13:30:14 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105191130.NAA53601.aeb@vlet.cwi.nl>
To: andrewm@uow.edu.au, viro@math.psu.edu
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code inuserspace
Cc: bcrl@redhat.com, clausen@gnu.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

    > > (2) what about bootstrapping?  how do you find the root device?
    > > Do you do "root=/dev/hda/offset=63,limit=1235823"?  Bit nasty.
    > 
    > Ben's patch makes initrd mandatory.

    Can this be fixed?  I've *never* had to futz with initrd.
    Probably most systems are the same.  It seems a step
    backward to make it necessary.

I don't think so. It is necessary, and it is good.

But it is easy to make the transition painless.
Instead of the current choice between INITRD (yes/no)
we have INITRD (default built-in / external).
The built-in version can then slowly become smaller and die.

Andries
