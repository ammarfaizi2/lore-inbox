Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbQLLUio>; Tue, 12 Dec 2000 15:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLLUie>; Tue, 12 Dec 2000 15:38:34 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:22792 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129601AbQLLUiY>;
	Tue, 12 Dec 2000 15:38:24 -0500
Date: Tue, 12 Dec 2000 21:07:48 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
Message-ID: <20001212210748.C12995@spaans.ds9a.nl>
In-Reply-To: <20001212160605.A1835@spaans.ds9a.nl> <Pine.LNX.4.10.10012121047140.2239-100000@penguin.transmeta.com> <14902.33510.300257.269105@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14902.33510.300257.269105@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Dec 13, 2000 at 06:56:22AM +1100
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 06:56:22AM +1100, Neil Brown wrote:

> Guilt by association :-)
> 
> What this bit of code (complete_stripe/raid5_end_buffer_io) is doing
> is observing that it as completed some I/O request that was made of
> the raid5 device and is calling the b_end_io on the buffer_head that
> is was passed.  So it is not one of raid5's buffers that has the bad
> b_end_io, but someone else's buffer that raid5 was asked to service.
> 
> You say "things with a mysql-db on a raid5-device".  Can I interpret
> this to mean that mysql was talking driectly to /dev/md0, or is there
> some filesystem in-between?
> Either way, I expect Linus' suggestion will provide the answer.

Will try to reproduce this, with Linus' suggestion; btw, this mysql-db is
running on ext2, nothing exotic.

Regards,
-- 
  Q_.        Jasper Spaans  <mailto:jspaans@mediakabel.nl>        -o)
 `~\         Conditional Access/DVB-C/OpenTV/Unix-adviseur        /\\
Mr /\                                                            _\_v
Zap     Een ongezellig dure consultant nodig? Mail sales@insultant.nl
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
