Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTIFVcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTIFVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 17:32:41 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:63401 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S261977AbTIFVck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 17:32:40 -0400
Subject: Panic when finishing raidreconf on 2.4.0-test4 with preempt
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062883950.1341.26.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 06 Sep 2003 17:32:30 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19vkfe-00081v-11*DqThgpfxFyQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done this twice now, I'd prefer not to do it again, but can upon
request, if you really need the oops output.

Running raidreconf to expand a 4 disk array to 5, seems to work
correctly until the very end.  I'm guessing it is as the RAID super
block is being written.  A preempt error is triggered and the kernel
panics.  Upon reboot the MD driver doesn't think the 5th disk is valid
for consideration in the array and skips over it.  Leaving a very
corrupted file system.

