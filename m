Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314474AbSDRWFD>; Thu, 18 Apr 2002 18:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSDRWFC>; Thu, 18 Apr 2002 18:05:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36082 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314474AbSDRWFB>;
	Thu, 18 Apr 2002 18:05:01 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 19 Apr 2002 00:05:00 +0200 (MEST)
Message-Id: <UTC200204182205.g3IM50X05349.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de
Subject: Re: [PATCH] IDE TCQ #4
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > It sure is... sr doesn't do it and lots of others don't as well, so I
    > suppose we could rip it out. We already require reblocking with loop in
    > those cases anyway.

As a stopgap measure, not because we are so proud of that solution.

    For the file system ones. It would be nice to be able to handle non power
    of two block sizes as well through the block interface (even if it means we
    hand back a 4K buffer that the caller is required to know is partly full).
    That would remove a lot of special case magic for audio/video

Yes, it is as if non power-of-two block sizes are getting more
common. In the good old days one occasionally saw IBM SCSI disks
with strange sector size, difficult to read, but recently there
have been many cases of (power-of-two plus metadata), with e.g.
528 or 572 bytes. There have also been cases of small power-of-two,
like 64 or 256 bytes.
All kinds of strange constructions can be avoided if the block layer
just handles arbitrary block size, up to some reasonable limit.

Andries
