Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbTHaQqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTHaQqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:46:47 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:35346 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP id S262613AbTHaQqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:46:33 -0400
Date: Mon, 1 Sep 2003 00:44:56 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Chua <jeff89@silk.corp.fedex.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] hda:end_request: I/O error, dev 03:00 (hda), sector 0
In-Reply-To: <1062335526.31332.41.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.42.0309010040380.1441-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/01/2003
 12:46:28 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/01/2003
 12:46:30 AM,
	Serialize complete at 09/01/2003 12:46:30 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 31 Aug 2003, Alan Cox wrote:

> On Sul, 2003-08-31 at 05:24, Jeff Chua wrote:
> > end_request: I/O error, dev 03:00 (hda), sector 2
>
> You don't have IDE hard disk support included so the kernel finds
> it has no way to read the partition table.

You're right. After recompiling with CONFIG_BLK_DEV_IDEDISK=y instead of
"m" (module), the error went away.

But, that means IDE still can't be compile as a module. I would like to
be able to load and unload ide from ramdisk. Is there a patch to make ide
modular?

Thanks,
Jeff



