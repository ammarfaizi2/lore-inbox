Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131913AbQKCU7x>; Fri, 3 Nov 2000 15:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131907AbQKCU7o>; Fri, 3 Nov 2000 15:59:44 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131702AbQKCU7e>;
	Fri, 3 Nov 2000 15:59:34 -0500
Message-ID: <20001103201845.A131@bug.ucw.cz>
Date: Fri, 3 Nov 2000 20:18:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu> <20001102171717.L1876@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001102171717.L1876@redhat.com>; from Stephen C. Tweedie on Thu, Nov 02, 2000 at 05:17:17PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The patch I sent fully implements O_SYNC (actually, it implements
> O_DSYNC, which is allowed to skip the inode sync if the only attribute
> which has changed is the timestamps) and fdatasync.  It's easy for me
> to make the DSYNC selectable via sysctl for full SU compliance, and I
> know of other unixes that already do this --- you really don't want
> existing database applications suddenly to start seeking to the inode
> block for every O_SYNC write.

It looks to me like times updates are upper-bound by once per second,
no? So this should not be (big) issue.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
