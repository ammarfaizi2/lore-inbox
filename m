Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUAWTrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUAWTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:47:23 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:19101 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S266683AbUAWTrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:47:16 -0500
Date: Fri, 23 Jan 2004 21:47:14 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1: process start times by procps
Message-ID: <20040123194714.GA22315@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm very sorry if this is already reported. In 2.6.1 (and earlier) ps does
not report the process start times correctly. (Either procps 2.0.18 or
3.1.15). The problem shows when uptime is large enough, now it is 14 days.
After bootup ps showed the right time.

For example, I started this bash process really at 21:24 (date showed 21:24
then):

kaukasoi 22108  0.0  0.2  4452 1532 pts/4    R    21:28   0:00 /bin/bash

Here is a line from w:
kaukasoi pts/4    -                 9:24pm  0.00s  0.06s  0.00s  w 

BTW, is it normal that all the time stamps at the proc directory are not the same?

elektroni kaukasoi ~ > ls -l /proc/22108
total 0
-r--------    1 kaukasoi fys             0 Jan 23 21:27 auxv
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:24 cmdline
lrwxrwxrwx    1 kaukasoi fys             0 Jan 23 21:27 cwd -> /home/kaukasoi
-r--------    1 kaukasoi fys             0 Jan 23 21:24 environ
lrwxrwxrwx    1 kaukasoi fys             0 Jan 23 21:27 exe -> /bin/bash
dr-x------    2 kaukasoi fys             0 Jan 23 21:24 fd
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:27 maps
-rw-------    1 kaukasoi fys             0 Jan 23 21:27 mem
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:27 mounts
lrwxrwxrwx    1 kaukasoi fys             0 Jan 23 21:27 root -> /
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:24 stat
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:27 statm
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:24 status
dr-xr-xr-x    3 kaukasoi fys             0 Jan 23 21:27 task
-r--r--r--    1 kaukasoi fys             0 Jan 23 21:27 wchan
elektroni kaukasoi ~ > 

