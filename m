Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbTIOW2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTIOW2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:28:39 -0400
Received: from vena.lwn.net ([206.168.112.25]:43427 "HELO lwn.net")
	by vger.kernel.org with SMTP id S261650AbTIOW2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:28:38 -0400
Message-ID: <20030915222837.23849.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: exporting register_chrdev_region and friends?
cc: viro@parcelfarce.linux.theplanet.co.uk
From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 15 Sep 2003 16:28:37 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been playing with the registration of char devices in the brave, new,
big dev_t world, and that means looking at register_chrdev_region() and the
cdev_ functions.  But, it seems, these functions are not exported to
modules.  That's easily fixed, but I was wondering: is this omission
deliberate?  Should modules be able to use those functions to access larger
device numbers, or is there some other interface envisioned that modules
should be using?

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
