Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUCRBJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 20:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbUCRBJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 20:09:52 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:34435 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262268AbUCRBJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 20:09:11 -0500
Subject: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079572101.2748.711.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Mar 2004 17:08:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm wondering is there any way in Linux to do proper fsync(), which
makes sure data is written to the disk.

Currently on IDE devices one can see, fsync() only flushes data to the
drive cache which is not enough for ACID guaranties database server must
give. 

There is solution just to disable drive write cache, but it seems to
slowdown performance way to much.

I would be also happy enough with some global kernel option which would
enable drive cache flush on fsync :) 


Mac OS X also has this "optimization", but at least it provides an
alternative flush method for Database Servers:

fcntl(fd, F_FULLFSYNC, NULL)

can be used instead of fsync() to get true fsync() behavior. 

-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

