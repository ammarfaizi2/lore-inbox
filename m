Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbQKKRH7>; Sat, 11 Nov 2000 12:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbQKKRHt>; Sat, 11 Nov 2000 12:07:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30470 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131447AbQKKRHg>; Sat, 11 Nov 2000 12:07:36 -0500
Date: Sat, 11 Nov 2000 11:03:25 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Ralf Baechle <ralf@uni-koblenz.de>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001111110325.A9464@vger.timpanogas.org>
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com> <3A0C76C0.CAC8B9D4@timpanogas.org> <20001111024440.E29352@bacchus.dhis.org> <3A0CA4F5.4715FE49@transmeta.com> <20001111125420.B921@inspiron.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001111125420.B921@inspiron.suse.de>; from andrea@suse.de on Sat, Nov 11, 2000 at 12:54:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 12:54:20PM +0100, Andrea Arcangeli wrote:
> On Fri, Nov 10, 2000 at 05:46:29PM -0800, H. Peter Anvin wrote:
> > Yes, the documentation is broken.  Linus did in fact implement this
> 
> Well, also the implementation could be improved IMHO, think when we have one
> houndred of tasks sleeping in uninterruptible mode because the nfs server is
> down for maintenance. They're no loading the machine at all for half an hour
> even while the load is 100. For sure the fix is not to account only runnable
> tasks though, since when the machine trashes into swap all tasks blocks and
> they almost never runs but in such a case we must report that all tasks are
> trying to make progress and that they're effectively loading the machine even
> if they sleeps in uninterruptible mode all the time. I'd prefer a generic
> approch but also a magic for some case like nfs server down could take care of
> that.

I've actualy seen this with a bunch of NFS clients idle, and sendmail stops
delivering email until the load average drops.  What's of more concern is
the intense VM implementation Rik has done -- it's a great piece of work,
but it appears when heavy swapping is going on, sendmail also stops 
delivering email as well.  

8)

Jeff

> 
> Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
