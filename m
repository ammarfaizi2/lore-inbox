Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131829AbRAIAWq>; Mon, 8 Jan 2001 19:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136702AbRAIAWg>; Mon, 8 Jan 2001 19:22:36 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:7429 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131829AbRAIAWZ>; Mon, 8 Jan 2001 19:22:25 -0500
Date: 08 Jan 2001 23:39:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7tSnVTQ1w-B@khms.westfalen.de>
In-Reply-To: <93d7fr$429$1@penguin.transmeta.com>
Subject: Re: setfsuid on ext2 weirdness (2.4)
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <93d7fr$429$1@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 08.01.01 in <93d7fr$429$1@penguin.transmeta.com>:

> And hey, if you think the above is confusing, try making your /dev/null
> a regular (writable) file by mistake.  Now THAT will be confusing as
> hell: things will actually work surprisingly well, but some thing
> _really_ don't work the way they are intended to.  And chasing it down
> is an exercise in futility.  Yes, I've done that at least twice as root
> by mistake.

So have I. It's so damned easy. Just remove the original; pretty soon  
*something* will create a plain file there.

Now you have:

* Actual input reading from /dev/null (and it changes!).
* Unusual permissions on /dev/null

Fun fun fun. Many unusual failure modes.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
