Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131754AbRASNmU>; Fri, 19 Jan 2001 08:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131814AbRASNmL>; Fri, 19 Jan 2001 08:42:11 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:61451 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131754AbRASNmE>; Fri, 19 Jan 2001 08:42:04 -0500
Date: 18 Jan 2001 20:46:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7u7k1VlXw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.10.10101180822020.18072-100000@penguin.transmeta.com>
Subject: Re: Is sendfile all that sexy?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <200101181001.f0IA11I25258@webber.adilger.net> <Pine.LNX.4.10.10101180822020.18072-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 18.01.01 in <Pine.LNX.4.10.10101180822020.18072-100000@penguin.transmeta.com>:

> if your "normal" usage pattern really is to just move the data without
> even looking at it, then you have to ask yourself whether you're doing
> something worthwhile in the first place.

Web server. FTP server. Network file server. cp. mv. cat. dd.

In short, vfs->net (what sendfile already does) and vfs->vfs are probably  
the most interesting applications, with net->vfs as a possible third.  
Classical bulk data copy applications.

All the other stuff I can think of really does want to look at the data,  
and we can already handle virtual memory just fine with read/write/mmap.

MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
