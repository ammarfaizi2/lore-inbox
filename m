Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUAGX1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAGXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:24:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:12501 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262458AbUAGXY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:24:27 -0500
Date: Wed, 7 Jan 2004 15:21:37 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] sysfs sound class patches - [0/2]
Message-ID: <20040107232137.GC2540@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are 2 sysfs sound class patches against 2.6.1-rc2 (but should apply
to 2.6.0) that add sysfs support for OSS and ALSA drivers.  This enables
udev to see sound devices and create nodes for them.

I've divided it up into 2 patches:
	- sound support for OSS drivers
	- sound support for ALSA drivers

The ALSA driver patch requires the OSS driver (due to where struct
sound_class is declared), and it also modifies the i810 ALSA sound
driver to provide a symlink in sysfs to the pci device being controlled
by the device node.

I can provide patches to the other ALSA drivers to also add this
information, as it's quite useful if you have more than one sound device
in your system at once.

These patches require the sysfs simple class patch that is currently in
the -mm tree.

Andrew, can you please add these two patches to your -mm tree?

thanks,

greg k-h
