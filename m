Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbSIZFqV>; Thu, 26 Sep 2002 01:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbSIZFqV>; Thu, 26 Sep 2002 01:46:21 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:129 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S262193AbSIZFqU>; Thu, 26 Sep 2002 01:46:20 -0400
Date: Wed, 25 Sep 2002 22:51:37 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: SMART *causing* disk lossage?
Message-ID: <Pine.LNX.4.44.0209252246390.26506-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i suspect this is a controller problem, but i thought i'd mention it
anyhow.

i've had 5 disk problems on one of my promise 100tx2 cards -- one of them
was on /dev/hdk, the other 4 on /dev/hdi... one of the 4 actually could
have been a dead disk (the drive didn't respond elsewhere either).  but
the rest seemed to clear up on power off/on.

in 4 of the instances, smartd was the first to log anything about a dead
disk -- it didn't log any change in the smart parameters, just that it
couldn't reach the drive.  following smartd's complaint were kernel
messages about resetting the bus, and so forth.

the 5th time, this evening, i was running hddtemp by hand -- and the
failure appeared to occur at exactly that moment.

the drives are maxtor D740X 80GB (6L080J4 or 6L080L4).

is it at all possible that using SMART is causing some sort of screwup in
the kernel on the drives?  (i mean anything is possible, i'm just grasping
at straws here.)

i ended up replacing the controller tonight, 'cause it's just too
coincidental that all this is happenning on /dev/hdi (i've replaced the
hdi disk and cable already).

anyhow, kernel rev is 2.4.19-pre7-ac4.

-dean

