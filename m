Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUHFQkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUHFQkH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268171AbUHFQkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:40:06 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:41605 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268180AbUHFQey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:34:54 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Doug McNaught'" <doug@mcnaught.org>,
       "'Daniel Pittman'" <daniel@rimspace.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: EXT intent logging
Date: Fri, 6 Aug 2004 09:36:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <87pt64o0yp.fsf@asmodeus.mcnaught.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcR7uMHe1yUTerqaTVSfFdpspzi78QAGmFPA
Message-Id: <S268180AbUHFQey/20040806163555Z+829@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But if it doesn't do writes to the journal first, how does it identify
transactions that were "in flight" when the system went down to reverse
them? How do you catch a parial update to an inode for instance?

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Doug McNaught
Sent: Friday, August 06, 2004 6:23 AM
To: Daniel Pittman
Cc: linux-kernel@vger.kernel.org; Buddy Lumpkin
Subject: Re: EXT intent logging

Daniel Pittman <daniel@rimspace.net> writes:

> What is normal is that ext3 will perform an *occasional* fsck - by
> default, once a month or every thirty-odd mounts - to catch any
> corruption that has been missed by the journaling.

And if you don't want this to happen, you can use 'tunefs' to turn it
off, and rely entirely on journal replays.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

