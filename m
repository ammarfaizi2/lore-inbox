Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbUCCT1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbUCCT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:27:23 -0500
Received: from [80.72.36.106] ([80.72.36.106]:19387 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262554AbUCCT1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:27:22 -0500
Date: Wed, 3 Mar 2004 20:27:17 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: linux-hotplug-devel@vger.kernel.org
Cc: greg@kroach.com, linux-kernel@vger.kernel.org
Subject: [QUESTION/PROPOSAL] udev (fwd)
Message-ID: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PLEASE CC LKML or me because I am not subscribed to LHD!]

Greg asked for it, so here it is:

Question:

If I understand well, currently, when kernel detects new device, it 
creates all important files in /sys for it, excluding device file.

So, (sorry if it was asked 100000000 times...
... but) why when kernel detects new device or module is loaded, no device 
file in sysfs is created? The device files in /dev would be only links to 
these in /sys. 

This way we could stop care about major/minor numbers and leave it to sysfs...
And it maybe could decrease the possible races related to udev because it 
would only create or remove links to files in /sys.

Programs will be able to easily find, for what device and where located in 
system (buses, etc.) the device file in /dev is - with readlink.

And it should make the entire process more clear.

What You think about it?



thanks and sorry for my english

Grzegorz Kulewski

