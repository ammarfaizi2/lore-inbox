Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTEIXhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTEIXhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:37:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9931 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263579AbTEIXhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:37:06 -0400
Date: Fri, 9 May 2003 16:51:42 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Driver core changes for 2.5.69
Message-ID: <20030509235142.GA3506@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three small changesets that fix up some stuff in the driver
class code.  They do the following:
	- restore back the driver link in the sysfs class representation
	  that I removed based on my previous class changes.
	- fix the cpu frequency code to work properly again (I messed up
	  when porting it to the new class code.)
	- remove an unneeded line in the class code.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/class-2.5

thanks,

greg k-h

 drivers/base/class.c |   18 +++++++++++++++++-
 include/linux/cpu.h  |    1 +
 kernel/cpufreq.c     |    2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)
-----

Greg Kroah-Hartman:
  o driver core: remove unneeded line in class code
  o driver core: Add driver symlink to class devices in sysfs

Jonathan Corbet:
  o cpufreq class fix

