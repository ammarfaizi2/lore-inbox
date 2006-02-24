Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWBXQtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWBXQtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWBXQtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:49:04 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:39832 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932376AbWBXQtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:49:02 -0500
Date: Fri, 24 Feb 2006 09:49:01 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Missing piece from as659
Message-ID: <20060224164901.GQ28587@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan, you didn't cc the pci mailing list on the original patch.
http://www.ussg.iu.edu/hypermail/linux/kernel/0602.2/2673.html

You only fix pci_get_subsys; pci_get_class has the same bug.

If it is a bug, of course.  It's not clear to me whether it's permissible
to call pci_dev_put under a spinlock or not.  That boils down to whether
kobject ->release methods can sleep or not.  That isn't documented in
Documentation/kobject.txt and I rather think it should be.
