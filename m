Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273665AbRIQTei>; Mon, 17 Sep 2001 15:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbRIQTe3>; Mon, 17 Sep 2001 15:34:29 -0400
Received: from d104.as26.nwbl1.wi.voyager.net ([169.207.114.104]:20228 "EHLO
	udcnet.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S273567AbRIQTeU>; Mon, 17 Sep 2001 15:34:20 -0400
Date: Mon, 17 Sep 2001 14:34:42 -0500 (CDT)
From: David Acklam <dackl@post.com>
To: <linux-kernel@vger.kernel.org>
Subject: compiled-in (non-modular) USB initialization bug
Message-ID: <Pine.LNX.4.30.0109171430130.3275-100000@udcnet.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few months ago I posted a bug report about the Pegasus driver not
initializing  (or not initializing fast enough to work with NFS-Root) when
compiled-in. I've found that this is not specific to the
pegasus, as I have recently noticed that the kernel 'driver-initialized'
messages for my USB mouse and keyboard (i.e. HID devices) come up AFTER
init has been started. These drivers are also 'compiled-in'

The problem this poses is that some applications (like NFSRoot) need
access to USB devices BEFORE the kernel mounts filesystems/starts init.



