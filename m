Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTLWVbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLWVbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:31:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:48095 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262522AbTLWVbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:31:37 -0500
Date: Tue, 23 Dec 2003 13:24:59 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs class patches - take 2 [0/5]
Message-ID: <20031223212459.GA15700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the sysfs class patches reworked against a clean 2.6.0 tree.
I've created a class_simple.c file that contains a "simple" class device
interface.  I've then converted the tty core to use this interface (the
combo of these two patches makes for no extra code added).

Then there are 3 patches, adding class support for misc, mem, and vc
class devices.  As the interface to add simple class support for devices
is now so low, I feel that we do need to have mem class support as to
not special case any char device.

With these patches, it's now much easier for others to implement class
support for remaining char drivers/subsystems that do not have it yet.

Andrew, can you please remove the following 3 patches from your
2.6.0-mm1 tree:
	sysfs-mem-device-support.patch
	sysfs-misc-device-support.patch
	sysfs-vc-device-support.patch

and add these 5 patches instead?  The sysfs-oops-fix.patch needs to
stay.

thanks,

greg k-h
