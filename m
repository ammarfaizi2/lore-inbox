Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSH0ABf>; Mon, 26 Aug 2002 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSH0ABe>; Mon, 26 Aug 2002 20:01:34 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:4108 "EHLO mx3.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S312558AbSH0ABe>;
	Mon, 26 Aug 2002 20:01:34 -0400
Date: Tue, 27 Aug 2002 08:05:14 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption
In-Reply-To: <1030355656.16618.32.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208270758080.15296-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/27/2002
 08:05:48 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/27/2002
 08:05:49 AM,
	Serialize complete at 08/27/2002 08:05:49 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Aug 2002, Alan Cox wrote:

> > 	RAMDISK: Compressed image found at block 0 ... then stuck!
> Force a 1K block size when you make the fs

That was the default for mke2fs.

Tried compress instead of gzip. Same problem. I guess the compressed file
is too big for the kernel. The 8MB compressed (from 24MB) didn't work. 6MB
compressed from 18MB worked. The 24MB filesystem has just one extra junk
file in /tmp to fill up the filesystem to 90% and this caused the system
to hang.

I'm thinking it could be the ungzip function in the kernel that's causing
the problem.


Jeff.

