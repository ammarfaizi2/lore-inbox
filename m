Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUDSGHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbUDSGHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:07:44 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:60086 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263188AbUDSGHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:07:40 -0400
X-OB-Received: from unknown (205.158.62.182)
  by wfilter.us4.outblaze.com; 19 Apr 2004 06:06:09 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: ltp-list@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Date: Mon, 19 Apr 2004 01:07:22 -0500
Subject: Strace Test Take 2
X-Originating-Ip: 67.113.20.209
X-Originating-Server: ws3-6.us4.outblaze.com
Message-Id: <20040419060722.6DFE31CE505@ws3-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second approach at Strace Test.

Basically Strace test runs a lot of LTP tests.  The 
difference is that it calls traces the system calls 
from the LTP tests and calls them again with improper
values.  That adds an extra kick.  I think Strace 
Test might be the fastest general purpose kernel 
crasher there is.

In this version, I added some new improper values to
try, based on some source code that Dave Jones wrote.
The other effective change was to start multiple 
instance of the same test at the same time.  That 
helps trigger race conditions.

I tried testing on 2.4 and it was really stable. 
On 2.6, I was able to simulate an SMP kernel using 
the preempt code and that helps locate race 
conditions.  I wasn't able to test a 2.2 kernel 
but my guess is that it's pretty stable, especially 
with a UP kernel.

http://67.113.20.209/strace_test-2.tar.gz

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

