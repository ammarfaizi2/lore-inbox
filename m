Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131186AbRAITNR>; Tue, 9 Jan 2001 14:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130766AbRAITNH>; Tue, 9 Jan 2001 14:13:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:47878 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129826AbRAITMv>;
	Tue, 9 Jan 2001 14:12:51 -0500
Message-ID: <3A5B61F7.FB0E79C1@innominate.de>
Date: Tue, 09 Jan 2001 20:09:43 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr> <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> (This is why I worked so hard at getting the PageDirty semantics right in
> the last two months or so - and why I released 2.4.0 when I did. Getting
> PageDirty right was the big step to make all of the VM stuff possible in
> the first place. Even if it probably looked a bit foolhardy to change the
> semantics of "writepage()" quite radically just before 2.4 was released).

On the topic of writepage, it's not symmetric with readpage at the
moment - it still takes (struct file *).  Is this in the cleanup
pipeline?  It looks like nfs_readpage already ignores the struct file *,
but maybe some other net filesystems are still depending on it.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
