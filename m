Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTHCAi4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 20:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTHCAi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 20:38:56 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:50070 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S270479AbTHCAiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 20:38:54 -0400
Subject: Re: 2.6.0-test2-mm3 and mysql
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1059871132.2302.33.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Aug 2003 20:38:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mysql doesn't start on this kernel. This is a x86, preempt, ext2/3, UP
system. I get this in the mysql error log,

030802 20:01:17  mysqld started
030802 20:01:18  InnoDB: Error: the OS said file flush did not succeed
030802 20:01:18  InnoDB: Operating system error number 5 in a file
operation.
InnoDB: See http://www.innodb.com/ibman.html for installation help.
InnoDB: Look from section 13.2 at http://www.innodb.com/ibman.html
InnoDB: what the error number means or use the perror program of MySQL.
InnoDB: Cannot continue operation.
030802 20:01:18  mysqld ended

I also did an strace of mysql trying to start and when I tried to copy
the strace file to root's home I got some sort of IO error. I don't
remember the error exactly but I decided to run at that point and
rebooted. The file did seem to copy ok according to diff.

http://zeke.yi.org/linux/2.6.0-test2-mm3.strace.mysql
http://zeke.yi.org/linux/2.6.0-test2-mm3-config

BTW, CONFIG_DEBUG_INFO=y seems to make this kernel huge. I couldn't even
install the sucker because I didn't have enough space for the modules.
35 MB wasn't enough.

One last thing, I have started seeing mysql database corruption
recently. I am not sure it is a kernel problem. And I don't know the
exact steps to reproduce it, but I think I started seeing it with
-test2-mm2. I haven't ever seen db corruption in the 8-12 months I have
being playing with mysql/php.

None of these problems is critical for me (and they could be pilot
error) but I thought I should point them out.

Regards,

Shane

