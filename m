Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbTFUXwf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264828AbTFUXwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:52:35 -0400
Received: from grunt3.ihug.co.nz ([203.109.254.43]:3269 "EHLO
	grunt3.ihug.co.nz") by vger.kernel.org with ESMTP id S264731AbTFUXwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:52:30 -0400
Date: Sun, 22 Jun 2003 11:55:27 +1200 (NZST)
From: John Duthie <john@beyondhelp.co.nz>
X-X-Sender: spudgun@hades.internal.beyondhelp.co.nz
Reply-To: john@beyondhelp.co.nz
To: linux-kernel@vger.kernel.org
Subject: kswapd 2.4.2? ext3 
Message-ID: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
X-I-Opt-Out-NOW: E-Mail Addresses in this message may not be used to Deliver Unsolicited Commercial E-mail - This E-Mail message is NOT a request to subscribe to any E-mail advertising service or list
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't think kswap should be doing this ....

- ------->8
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:12 init [3]
    2 ?        SW     0:00 [keventd]
    3 ?        SWN    0:03 [ksoftirqd_CPU0]
    4 ?        Z      0:14 [kswapd] <defunct>
    5 ?        SW     0:00 [bdflush]
    6 ?        SW     0:02 [kupdated]
    7 ?        SW     0:07 [kjournald]
   23 ?        SW     0:03 [kjournald]
   24 ?        SW     0:00 [kjournald]
   25 ?        SW     0:02 [kjournald]
   26 ?        SW     0:03 [kjournald]
   27 ?        SW     0:19 [kjournald]
- ------->8

ext3 fs under load for 24+ hours ( was not defunct 12 hours ago )

P100,  80 GB HDD

             total       used       free     shared    buffers     cached
Mem:         94992      93528       1464          0       9500      33264
-/+ buffers/cache:      50764      44228
Swap:       396600      15384     381216

this machine was stable until I upgraded to ext3 with the 80 gb hdd ..

2.4.20 and 2.4.21 both do this ..

-- 
John Duthie
E-Mail:   <jmduthie@ihug.co.nz>
Phone:    +64  9 825 0325
Cell:     +64 25 273 4832
ICQ:      14794755
Web:      http://www.beyondhelp.co.nz/
 please read http://www.beyondhelp.co.nz/contact.html _before_
  contacting me with any Unsolicited Electronic Messages.
