Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTIQUSh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 16:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTIQUSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 16:18:37 -0400
Received: from mail5.intermedia.net ([206.40.48.155]:44807 "EHLO
	mail5.intermedia.net") by vger.kernel.org with ESMTP
	id S262652AbTIQUSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 16:18:34 -0400
Subject: [CVS] How do I get 'cvs history' to work for linux-2.5 ?
From: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Zultys Technologies Inc.
Message-Id: <1063829747.1602.20.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Sep 2003 13:15:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I use cvs access for the linux kernel tree, and I need 'cvs history' in
order to track the overall state (and staleness) of my local cvs tree
and embed it into the kernel that I build. So how do I get cvs history
for the kernel tree ? Currently 'cvs history' returns -

cvs [server aborted]: cannot open history file:
/home/cvs/CVSROOT/history: No such file or directory


The CVS server is accessed by the following URL -

:pserver:anonymous@cvs.kernel.org:/home/cvs


FYI, 'host cvs.kernel.org' returns the following:

cvs.kernel.org is an alias for kernel.bkbits.net.
kernel.bkbits.net has address 64.240.166.241


Is there a solution or an alternative ?

thanks,
Ranjeet.

------------------------------------------------------------------------------------------------------
A bit of history & a couple of observations/comments about bk and cvs
access to the linux kernel code:

(Internally, we do not use bk for the kernel and so learning bk was
primarily a background process, not a job-related need.)

1. For the last 8 months or so, I've used bk as a read-only mechanism to
view the changesets and keep track of 2.6 kernel changes. As a read-only
access mechanism for the linux kernel source tree, bk is trivially easy
to use (but a bit slow in terms of bk resolve etc). Also 'bk pull' does
not do 'bk -r get -qS' automatically - which may/may not be a useful
default depending on the needs of the developer. For me, this was a
stumbling block in my bk learning process, although I did read that the
next version of bk will do bk get automatically.

2. Eventually, I reached a point where I needed my custom changes to the
2.6 kernel make system to track changes, status etc. That's when I
started editing my bk tree and started using bk as a read-write
mechanism. As part of my learning process, I realized that the
openlogging feature would be blogging my learning attempts for the whole
world to see. While I am comfortable with the fact that half the world
is smarter than I am, I am not comfortable with logging my mistakes on a
world-accessible blog - OpenLogging. Its like trying to figure out 2+2
while Albert Einstein is broadcasting you live on American Idol.

Path of least resistance was to use cvs instead of bk. So I started
using cvs.kernel.org

The primary reason for switching to cvs was:
1. bk read-write mode was quite non-intuitive UNTIL I realized that bk
cares more about s.Makefile than about Makefile itself. (I am
comfortable with cvs, PVCS, Perforce, ClearCase)

2. OpenLogging my bk learning attempts was not good for my self-esteem.

While using cvs.kernel.org, I realized that cvs history does not work
for the cvs.kernel.org tree.

-- 

Ranjeet Shetye
Senior Software Engineer
Zultys Technologies
Ranjeet dot Shetye2 at Zultys dot com
http://www.zultys.com/
 
The views, opinions, and judgements expressed in this message are solely
those of the author. The message contents have not been reviewed or
approved by Zultys.


