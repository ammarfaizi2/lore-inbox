Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280777AbRKYJSG>; Sun, 25 Nov 2001 04:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280779AbRKYJRy>; Sun, 25 Nov 2001 04:17:54 -0500
Received: from weta.f00f.org ([203.167.249.89]:3481 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S280777AbRKYJRt>;
	Sun, 25 Nov 2001 04:17:49 -0500
Date: Sun, 25 Nov 2001 22:19:26 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk hardware caching, performance, and journalling
Message-ID: <20011125221926.B9672@weta.f00f.org>
In-Reply-To: <3BFFE8A2.1010708@rueb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFFE8A2.1010708@rueb.com>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 12:36:18PM -0600, Steve Bergman wrote:

    1. Disk hardware caching defaults to ON. (hdparm -W1 /dev/hda)
    2. It makes a *big* difference in write performance.

I depends on the drive, my IDE drives do default to on, my SCSI drives
do not.

The difference in write performance doesn't seem to be a problem other
that in contrived situations (eg. streaming 5G of data to disk takes
the same amount of time either way, but untar something then 'sync' is
faster with the drive caching).

It also depends of your filesystems to some extent and the operations
being performed [1].

    So what are the implications here for journalling?  Do I have to
    turn off caching and suffer a huge performance hit?

Yes.  I do this on workstations and it doesn't seem to hurt in
practice (only in benchmarks).

I can't comment on your bonnie++ results and I have no idea how well
they reflect reality (I assume to a large extent they try to though).




  --cw

[1] XFS rm -rf some_large_dir bites with drive-caching off for example.
