Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRINUjY>; Fri, 14 Sep 2001 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270825AbRINUjO>; Fri, 14 Sep 2001 16:39:14 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4348
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S270848AbRINUjA>; Fri, 14 Sep 2001 16:39:00 -0400
Date: Fri, 14 Sep 2001 13:39:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How errorproof is ext2 fs?
Message-ID: <20010914133917.A8737@mikef-linux.matchmail.com>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E15hebh-0007QK-00@the-village.bc.nu> <3BA257A5.E74DDBAB@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA257A5.E74DDBAB@bluewin.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2001 at 09:16:53PM +0200, Otto Wyss wrote:
> > Ext3 is a journalled ext2. Its in the 2.4-ac kernel trees. Reiserfs in the
> > -ac tree also supports big endian boxes.
> > 
> At least ext2 and probably all the journalling fs lacks a feature the HFS+ from
> the Mac has (bad tongues might say "needs"), to keep open files without activity
> in a state where a crash has no effect. I don't know how it is done since I'm no
> fs expert but my experience with my Mac (resetting about once a month without
> loosing anything) shows that it's possible.
> 
> I'd rather like to see this feature appear in one fs for Linux (preferable
> ext2). I think it's always better to not have error instead of fixing them afterwards.
> 

You can.  Make sure that all mounts use the "sync" flag in /etc/fstab.

You need to remember that unix systems are designed to be in a stable
environment, and enable optimizations that rely on those conditions.  That
way, it can do more work in RAM which is faster than the disks.

If you expect to be in unstable conditions, you should take the speed hit,
and enable the sync flag.

Also remember, XFS, JFS, ReiserFS, and especially EXT3 take steps to do the
work for you without requiring the sync flag.

Mike
