Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270274AbRHWUjx>; Thu, 23 Aug 2001 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRHWUjn>; Thu, 23 Aug 2001 16:39:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58895 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S270264AbRHWUjh>; Thu, 23 Aug 2001 16:39:37 -0400
Date: Thu, 23 Aug 2001 16:36:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: CD mount with offset fails in 2.4.x
Message-ID: <Pine.LNX.3.96.1010823162815.1140A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting a CD using an offset, such as:
  mount -o ro,offset=51200 /dev/cdrom /mnt
works in 2.0 and 2.2 kernels. It does not work in any recent 2.4 kernel,
back through 2.4.4 or so.

I get CDs with binary data followed by an ISO9660 image, and I would
really rather not have to pull them to disk, etc, to read the human info
associated with the firmware. For some reason it gets an unknow or invalid
filetype message.

Copying the whole CD including firmware to disk and mounting with a file
in place of the /dev/cdrom works with offset. Using a 2.0.33 kernel on the
same hardware works (I left the old drive in and upgraded on another, so I
could try).

If this is some bizarre design decision could someone at least tell me so
before I try to find the problem and submit a patch? 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

