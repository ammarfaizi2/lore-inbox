Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278630AbRKFIP1>; Tue, 6 Nov 2001 03:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278642AbRKFIPR>; Tue, 6 Nov 2001 03:15:17 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:37259 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278630AbRKFIPM>; Tue, 6 Nov 2001 03:15:12 -0500
Date: 06 Nov 2001 09:10:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8CKC7-AHw-B@khms.westfalen.de>
In-Reply-To: <3BE77599.9CFB5CA9@zip.com.au>
Subject: Re: [Ext2-devel] disk throughput
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3BE77599.9CFB5CA9@zip.com.au>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@zip.com.au (Andrew Morton)  wrote on 05.11.01 in <3BE77599.9CFB5CA9@zip.com.au>:

> Linus Torvalds wrote:
> >
> > I do believe that there are probably more "high-level" heuristics that can
> > be useful, though. Looking at man common big trees, the ownership issue is
> > one obvious clue. Sadly the trees obviously end up being _created_ without
> > owner information, and the chown/chgrp happens later, but it might still
> > be useable for some clues.

Size of the parent directory might be another clue.

> I didn't understand your objection to the heuristic "was the
> parent directory created within the past 30 seconds?". If the
> parent and child were created at the same time, chances are that
> they'll be accessed at the same time?

Thought experiment:

Put stuff on a disk the usual slow way.

Backup. Mkfs. Restore.

Should the allocation pattern now be different? Why?

> And there's always the `chattr' cop-out, to alter the allocation
> policy at a chosen point in the tree by administrative act.

Much help that's going to be in the above scenario, given how tar calls  
chattr ... not.

> Any change in ext2 allocation policy at this point in time really,
> really worries me.  If it screws up we'll have 10,000,000 linux
> boxes running like dead dogs in a year. So if we _do_ make a change, I'd
> suggest that it be opt-in.  Call me a wimp.

Well, with Alex' cleanups, switchable policies might just become possible.

MfG Kai
