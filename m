Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbTGMOHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbTGMOHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:07:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30654
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268238AbTGMOHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:07:37 -0400
Subject: Re: DVD/CD Read Problem: cdrom_decode_status: status=0x51
	{DriveReady SeekComplete Error}
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Kessel <adam@bostoncoop.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713140627.GA761@joehill.bostoncoop.net>
References: <20030713140627.GA761@joehill.bostoncoop.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058105986.422.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 15:19:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 15:06, Adam Kessel wrote:
> I don't believe this is a userspace issue.  Other OS's are able to deal with
> playing video DVDs by skipping read errors quickly.  There should be some one
> way to tell the kernel not to keep retrying for certain (i.e., non-data)
> CD/DVDs.  I can't see any possible way to do this in application space, though.  

It is mostly a user space issue. A DVD drive takes a couple of seconds
to decide bad things have happened. A way to lower retries is definitely
sensible but thats different.

The unexpected NULL on the 2.5 case points to IDE layer bugs too btw.

Userspace should be using a thread pulling data at least ten or fifteen
seconds ahead of the UI, even with the retries toned down.

