Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbTGOPBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268294AbTGOPBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:01:46 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:30718 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268281AbTGOPBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:01:44 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6807.578262.720332@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:15:35 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH 0/5] relayfs
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 5 patches implement relayfs, adding a dynamic channel
resizing capability to the previously posted version.

relayfs is a filesystem designed to provide an efficient mechanism for
tools and facilities to relay large amounts of data from kernel space
to user space.  Full details can be found in Documentation/filesystems/
relayfs.txt.  The current version can always be found at
http://www.opersys.com/relayfs.

I'll be posting shortly a version of printk that replaces the static
printk buffer with a dynamically resizing relayfs channel.

Relayfs is also used as the buffering mechanism for recent development
versions of the Linux Trace Toolkit (LTT).

These patches are for 2.6.0-test1.
 
Known problems - using read() to read from a resized channel may
result in garbage.  This doesn't affect any current clients though
i.e. the dynamic printk I'll be posting or the Linux Trace Toolkit. 

Thanks to Rusty Russell for picking some nits in the previous version.

Comments welcome.

-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

