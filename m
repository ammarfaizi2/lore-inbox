Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRBWUCv>; Fri, 23 Feb 2001 15:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbRBWUCb>; Fri, 23 Feb 2001 15:02:31 -0500
Received: from ns.arraycomm.com ([199.74.167.5]:4013 "HELO
	bastion.arraycomm.com") by vger.kernel.org with SMTP
	id <S129669AbRBWUCY>; Fri, 23 Feb 2001 15:02:24 -0500
Message-Id: <5.0.2.1.2.20010223115723.025e9e38@pop.arraycomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 23 Feb 2001 12:00:37 -0800
To: "James A. Pattie" <james@pcxperience.com>, linux-kernel@vger.kernel.org
From: Jasmeet Sidhu <jsidhu@arraycomm.com>
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <20010222213633.A14395@bug.ucw.cz>
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com>
 <3A91A6E7.1CB805C1@pcxperience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As other posts have pointed out, if you have BAD HDMA cables, you will 
experience problems.  One thing I would suggest is that you 
add  kernel.*        /dev/console to your /etc/syslog.conf so that you see 
any errors resulting from the kernel code.  Also I would suggest that you 
open another virtual terminal and leave tail -f /var/log/messages and keep 
an eye on it when the system could possibly crash.  This should help you 
out a little bit.

At 09:36 PM 2/22/2001 +0100, Pavel Machek wrote:
>Hi!
>
> > I partitioned the 2 drives (on 1st and 2nd controller, both 1.3 GB each)
> > into 4 total partitions.  1st is swap and then the next 3, 1 primary, 2
> > extended are for raid 1 arrays.  I've given 20 MB to /boot (md0), 650MB
> > to / (md1) and the rest (400+MB) to /var (md2).  I format md0 as ext2
> > and md1 and md2 as reiserfs.  When I go to untar the image on the cd to
> > /mnt/slash (which has md1 mounted on it), the system extracts about 30MB
> > of data and then just stops responding.  No kernel output, etc.  I can
> > change to the other virtual consoles, but no other keyboard input is
> > accepted.  After resetting the machine, the raid arrays rebuild ok, and
> > reiserfs gives me no problems other than it usually replays 2 or 3
> > transactions.  If I tell tar to pickup on the last directory I saw
> > extracted, it gets about another 30MB of data and stops again.  I've
> > waited for the raid syncing to be finished or just started after the
> > arrays are available and it doesn't matter.
>
>Try running sync; sync; sync; ... while untarring.
>                                                                 Pavel
>--
>I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
>Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


- - -
Jasmeet Sidhu
Unix Systems Administrator
ArrayComm, Inc.
jsidhu@arraycomm.com
www.arraycomm.com


