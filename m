Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265545AbTF2DQd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 23:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbTF2DQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 23:16:32 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:23022 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265545AbTF2DQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 23:16:24 -0400
Message-ID: <3EFE5E39.4070509@pacbell.net>
Date: Sat, 28 Jun 2003 20:34:17 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net is down
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > From:     Alan Cox
 > Date:     2003-06-28 23:13:55
 >
 > On Sad, 2003-06-28 at 23:15, Dr. David Alan Gilbert wrote:
 > > Hmm - why should it suck so badly? Shouldn't USB 2 (yes I mean the
 > > 480Mbps) manage 40MByte/s+ ?

Custom devices certainly have done that, with drivers that keep
everything busy.  Last fall, one person reported 38+ MB/sec
from a VT8235.  The theoretical peak bandwidth for bulk traffic
(what most folk want) is 52 MByte/sec.

A Western Digital drive I tried gave me 27 MByte/sec with USB.
And I hate to say that the FireWire mode didn't work at all,
since I was curious how they'd compare!  (2.5.71 or so.)


 > I don't think you get the full 480Mbit/sec on a single device.
 > 5Mbyte/sec is a bit low

Some combinations of EHCI silicon, USB-to-IDE adapter, and IDE
work better than others ... I once switched a drive from one
EHCI controller to another (same host and OS, didn't reboot),
and went from 5 MB/s to 19 MB/sec.  That was on 2.4; with the
2.5 usb-storage, both controllers gave the higher speed.


 > 	but that may be some of the remaining work on
 > the USB EHCI drivers. I've not tried 2.5.x which may be way better here.

The key difference in 2.5 is that usb-storage queues requests,
no more slow page-at-a-time I/O.  It's the same EHCI driver
underneath, lately -- much improved since last September (or so)
when it first started to generate real user feedback.

- Dave

