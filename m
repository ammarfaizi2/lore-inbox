Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUBPFXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 00:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBPFXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 00:23:13 -0500
Received: from spf13.us4.outblaze.com ([205.158.62.67]:14989 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263107AbUBPFXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 00:23:09 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: ltp-list@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Date: Mon, 16 Feb 2004 00:22:57 -0500
Subject: [Announce] Strace Test
X-Originating-Ip: 67.113.20.209
X-Originating-Server: ws3-3.us4.outblaze.com
Message-Id: <20040216052257.A2C971D7214@ws3-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening,

I'm happy to announce the initial public release of 
Strace Test.  I believe Strace Test is the most 
aggressive general purpose kernel tester available.
Strace Test generally crashes my system within 
5 minutes (2.6.1-rc2).

Strace Test uses a modified version of strace 4.5.1.  
Instead of printing out information about system calls, 
the modified version calls the syscalls with improper 
values.  A patch and a binary for i386 are included 
in the strace_test tar ball.

Strace Test uses LTP to generate real world syscalls.  
Just unpack ltp and type 'make -k'.  You don't
need to install the test if you don't want to.

The modifications make the test scripts go haywire.  
To keep the test on track we restart it every 10 
seconds.  The first script is run as root and it 
spawns off the test as a test user.  Every 10 seconds
root kills off all the test user's processes and 
restarts the test.  The actual tests are run with 
user permissions.

Strace Test is available from:
http://67.113.20.209/strace_test.tar.bz2

Test Instructions (for i386)
Create a test user
Download and untar ltp (ltp.sf.net)
Cd to ltp and `make -k` 
Untar strace_test
cd strace_test && ./go_go.sh
Enter the path to ltp
Enter the test user

regards,
dan carpenter
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

