Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTLEAnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLEAnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:43:33 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:52457 "EHLO
	sbcs.cs.sunysb.edu") by vger.kernel.org with ESMTP id S263607AbTLEAnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:43:32 -0500
Date: Thu, 4 Dec 2003 19:43:19 -0500 (EST)
From: Avishay Traeger <atraeger@cs.sunysb.edu>
X-X-Sender: atraeger@compserv1
To: linux-kernel@vger.kernel.org
Subject: unsigned long event initialization
Message-ID: <Pine.GSO.4.53.0312041928280.19421@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to figure out exactly how Linux assigns generation numbers to
inodes.  In most filesystems (such as ext2/ext3) the generation number is
assigned to event++.  This variable is declared in kernel/timer.c, but
apparently not initialized.  I made 3 files, each one immediately after a
reboot, and this is the information I got:

generation#
10417bbc
bf612079
8cf4b829

>From what I can tell, event is only incremented in a few places in the fs
directory.  Can someone please explain if event is actually initialized,
and if so, to what?  And if it is initialized to a specific number, how
are these generation numbers so big and varied?

tia.

Avishay Traeger

File System and Storage Lab
Computer Science Department
Stony Brook University
