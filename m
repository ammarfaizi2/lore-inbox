Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266086AbRGIGod>; Mon, 9 Jul 2001 02:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266417AbRGIGoX>; Mon, 9 Jul 2001 02:44:23 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:64495 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266086AbRGIGoL>; Mon, 9 Jul 2001 02:44:11 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107090643.f696h9T6024429@webber.adilger.int>
Subject: Re: Q: sparse file creation in existing data?
In-Reply-To: <20010630113349.B50@toy.ucw.cz> "from Pavel Machek at Jun 30, 2001
 11:33:50 am"
To: Pavel Machek <pavel@suse.cz>
Date: Mon, 9 Jul 2001 00:43:08 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, "Ph. Marek" <marek@bmlv.gv.at>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel writes:
> > It could be used as a replacement for the truncate code, because then
> > truncate is simply a special case of punch, namely punch(0, end).
> 
> I do not think so. Truncate leaves you with filesize 0, while punch schould
> leave you with filesize of original file.

I can't recall the exact details (it's been a year since I looked at the
code), but I believe that the VFS sets the file size before the call to
truncate, so it didn't matter on the exact semantics of the punch call.
Truncate still existed, but it was just a wrapper calling the punch code
to punch out all of the existing blocks.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
