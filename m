Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130647AbRBWJAR>; Fri, 23 Feb 2001 04:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130832AbRBWJAI>; Fri, 23 Feb 2001 04:00:08 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129900AbRBWI5Q>;
	Fri, 23 Feb 2001 03:57:16 -0500
Message-ID: <20010222213633.A14395@bug.ucw.cz>
Date: Thu, 22 Feb 2001 21:36:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: "James A. Pattie" <james@pcxperience.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com>; from James A. Pattie on Mon, Feb 19, 2001 at 05:06:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I partitioned the 2 drives (on 1st and 2nd controller, both 1.3 GB each)
> into 4 total partitions.  1st is swap and then the next 3, 1 primary, 2
> extended are for raid 1 arrays.  I've given 20 MB to /boot (md0), 650MB
> to / (md1) and the rest (400+MB) to /var (md2).  I format md0 as ext2
> and md1 and md2 as reiserfs.  When I go to untar the image on the cd to
> /mnt/slash (which has md1 mounted on it), the system extracts about 30MB
> of data and then just stops responding.  No kernel output, etc.  I can
> change to the other virtual consoles, but no other keyboard input is
> accepted.  After resetting the machine, the raid arrays rebuild ok, and
> reiserfs gives me no problems other than it usually replays 2 or 3
> transactions.  If I tell tar to pickup on the last directory I saw
> extracted, it gets about another 30MB of data and stops again.  I've
> waited for the raid syncing to be finished or just started after the
> arrays are available and it doesn't matter.

Try running sync; sync; sync; ... while untarring.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
