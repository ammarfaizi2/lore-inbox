Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030547AbVKXAtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030547AbVKXAtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbVKXAtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:49:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:25573 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932535AbVKXAtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:49:39 -0500
Subject: Console rotation problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@gmail.com
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 11:45:50 +1100
Message-Id: <1132793150.26560.357.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonio !

I decided to give a quick test to console rotation on my g5 (radeonfb)
and couldn't get it to work.

When I tried echo'ing something in con_rotate, something very strange
happened:

pogo:/sys/class/graphics/fb0# echo "1" >con_rotate
benh@pogo:~$

As you can see, it looks like I pressed ctrl-D (which I didn't do) and
thus exited my shell session. Thus my shell session got killed some way.
Verified it twice. Also the console stopped displaying anything (that
is,whatever was displayed was still there but the cursor didn't blink
anymore and no new stuff got displayed). 

When I then tried to echo "0" back there, it just hung in the kernel
(probably on a semaphore, I could still use the box for a little while
before it completely locked up).

Ben.


