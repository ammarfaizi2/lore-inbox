Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUJ3RIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUJ3RIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 13:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbUJ3RIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 13:08:45 -0400
Received: from [195.56.65.174] ([195.56.65.174]:15375 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261206AbUJ3RIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 13:08:43 -0400
Subject: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099156115.14842.322.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 30 Oct 2004 19:08:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've used xfs and ext3 on a large ftp server with lots of files, and
when I do a 'find / -ls' with the kernel 2.6.10-rc1, the server crashes
with no Oops or other message. only the reset button give a response.. I
can reproduce it any time with find, but the point of crash is random,
it can crash on xfs and ext3 partitions too..  2.6.9 works fine in this
environment..


vm settings:

echo 16384 > /proc/sys/vm/min_free_kbytes
echo 28 > /proc/sys/vm/vfs_cache_pressure
echo 100 > /proc/sys/vm/swappiness

I've tried to double min_free_kbytes but didn't help


-- 
dap


