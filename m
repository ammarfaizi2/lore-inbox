Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285216AbRLRVpO>; Tue, 18 Dec 2001 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285210AbRLRVnw>; Tue, 18 Dec 2001 16:43:52 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:32828 "EHLO
	tsmtp2.mail.isp") by vger.kernel.org with ESMTP id <S285206AbRLRVms>;
	Tue, 18 Dec 2001 16:42:48 -0500
Date: Tue, 18 Dec 2001 22:45:00 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: ross@willow.seitz.com
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011218224500.B377@diego>
In-Reply-To: <20011217025856.A1649@diego> <13425.1008580831@nova.botz.org> <20011218003359.A555@diego> <20011218000145.A15150@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011218000145.A15150@willow.seitz.com>; from ross@willow.seitz.com on Tue, Dec 18, 2001 at 06:01:45 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001 06:01:45 Ross Vandegrift wrote:
> > This is my opinion:
> > 	-Something (reiserfs, anything) has caused fs corruption
> > 	-It should be repaired by reiserfsck, but it's broken :-((
> > 	-This corruption should NOT have happened, reiserfsck shouldn't
> > have to be used.
> > 	-I'm not a kernel hacker, so I can't try anything...what I know
> is
> > that
> > 		/etc in hc5 doesn't work. /usr, /var....works
> correctly.
> > 
> > Well, I'd like to know what's happened in my drive. Can somebody try to
> > give an explanation?
> 
> I've seen this happen when being careless about partitioning my drive. 
> If
> you changed your partition table and created the filesystem without a
> reboot
> you could be in for this problem.  If fdisk was unable to update the
> partition table after writing it out and you ran mkreiserfs, you just
> made a
> filesystem on the *old* partition, according to the *old* partition
> table.
> Upon rebooting, the disk will be synced to the new partition table.  If
> you
> happened to shrink the parition a bit, the filsystem is suddenly longer
> than
> the partition.
Before partitioning as now it is, I had the same problem. Perhaps it's due
to a fdisk bug.
If I see the message "Partitioning table couldn't be re-read" or something
like that, I always reboot. Perhaps I forgot rebooting, and this is the
problem, but it's very improbable

> 
> Ross Vandegrift
> ross@willow.seitz.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


