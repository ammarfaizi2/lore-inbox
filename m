Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUFDNc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUFDNc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 09:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUFDNcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 09:32:25 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44476 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263831AbUFDNbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 09:31:39 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Fri, 4 Jun 2004 15:34:48 +0200
User-Agent: KMail/1.5.3
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost> <200406041438.44706.bzolnier@elka.pw.edu.pl> <20040604124704.GA1946@suse.de>
In-Reply-To: <20040604124704.GA1946@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041534.48688.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 14:47, Jens Axboe wrote:
> On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > Well, thanks but I still think that your patch suits crappy code
> > perfectly (you know all the complains).
>
> I'm not on a crusade to clean up drivers/ide, in fact I could not care
> less it if rots away (thank fully it is doing just that, pata is going
> away). Most of your complaints are not valid in my opinion (->wrq usage

You are missing two facts:
- I'm on the _crusade_ to clean drivers/ide and merge them with libata later
- pata is (slowly) going away but support for it is not going _anywhere_
  (although some people are smoking 'libata pata' crack)

> is fine. it's not pretty, but it's not broken as long as you serialize
> access across the hwgroup of course). Like the rest, it's an artifact of
> how messy the code paths are in there. That could be cleaned too
> naturally, but that's someone elses job and I'm not about to increase my
> work load in that area.

Yep, you prefer to increase my work load instead.

> That you need to queue pre/post flushes to support barriers is a _driver
> implementation detail_ in my opinion. You don't want to even advertise

It is implementation braindamage IMO (but I'll buy it if rest is OK).

> that to upper layers. I will move a little of that into the block layer,
> if only because SATA will need it as well.
>
> As for REQ_DRIVE_TASK and ide_get_error_location(), well hell I do take
> patches! If there's something you consider broken, damnit send a patch

It is _your_ job to do it properly.

There are no double standards, 'IDE crap embargo' holds for everyone.

> to correct it and I'll surely merge it into the base if I agree it makes
> sense. That's the way to get changes done if you feel something should
> be different, snide remarks with basically zero detail is not.

I think I provided enough details few times already.
You can always ask in case of problems (keep linux-ide@ cc:-ed).

[ First thing to do is to use REQ_DRIVE_TASKFILE not REQ_DRIVE_TASK. ]

Cheers,
Bartlomiej

