Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268824AbRHBGxo>; Thu, 2 Aug 2001 02:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRHBGxf>; Thu, 2 Aug 2001 02:53:35 -0400
Received: from secure.webhotel.net ([195.41.202.80]:8565 "HELO
	secure.webhotel.net") by vger.kernel.org with SMTP
	id <S268824AbRHBGxX>; Thu, 2 Aug 2001 02:53:23 -0400
X-BlackMail: 213.237.118.153, there,  <snowwolf@one2one-networks.com>, 213.237.118.153
X-Authenticated-Timestamp: 08:59:29(CEST) on August 02, 2001
Content-Type: text/plain;
  charset="utf-8"
From: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
To: linux-kernel@vger.kernel.org
Subject: Wheel mice on thinkpad ps/2
Date: Thu, 2 Aug 2001 08:51:26 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010802065332Z268824-28344+348@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think this message didnt reach the mailing-list the first time, trying 
again.
Sorry if you see this message twice.
----------  Forwarded Message  ----------


Hi.
I've solved a long standing problem with using an extended mouse over the
ps/2 port on a thinkpad.  (search deja, I found bugreports dating back to
1998, all unanswered)
I discovered there is a "smart" device called a trackpoint controller, that
accumulates movement from both the trackpoints and the external mouse.
Provided it understands the external mouse! (it only understand standard
mice) A quick hack is disabling the trackpoint controller by sending 0xe2
0x4e, but a more general solution would be to write a linux driver that
autodetected a trackpoint controller with external mouse and disabled it.  In
that way it would be transparant to userspace drivers.

The easiest for my would be writing it into pc_keyb.c but that's not
appropiate. So where should I place the driver?
If I want advanced functionality, where I instead demultiplexes the
trackpoint and the external mouse into a /dev/psaux1 and -2, I need to take
over the aux interrupthandler. Otherwise I can just speak through the
standard psaux.
And what of the new input-class, should all inputdevices eventually move over
there, or just USB?

regards
-Allan

-------------------------------------------------------
