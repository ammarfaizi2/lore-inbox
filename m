Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129357AbQH3PMl>; Wed, 30 Aug 2000 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129320AbQH3PMa>; Wed, 30 Aug 2000 11:12:30 -0400
Received: from hermes.mixx.net ([212.84.196.2]:31501 "HELO hermes.mixx.net") by vger.kernel.org with SMTP id <S129139AbQH3PMU>; Wed, 30 Aug 2000 11:12:20 -0400
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: [ANNOUNCE] Tux2 Failsafe Filesystem project
Date: Wed, 30 Aug 2000 16:59:39 +0200
Organization: innominate
Distribution: local
Message-ID: <news2mail-39AD215B.8CD466C0@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 967647579 27243 10.0.0.90 (30 Aug 2000 14:59:39 GMT)
X-Complaints-To: news@innominate.de
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test6 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce the Tux2 Filesystem project.

Tux2 is a GPL-licensed variation on Linux's standard Ext2 filesystem,
Like a journalling filesystem, Tux2 is designed to be robust in the
event of an unexpected interruption such as a system crash, power
outage or a user that likes to hit the power switch without asking
first.  After such an interruption, Tux2 will restart with the
filesystem in a consistent, recently recorded state - no fsck or other
recovery operation is required.

Unlike a journalling filesystem, Tux2 does not use a journal or record
any extra state information on disk.  Instead, Tux2 uses a newly
designed algorithm called Phase Tree to control the order and
positioning of disk writes and allow the filesystem to move atomically
from one consistent state to the next with a single block write.

Details of the phase tree algorithm are available on the project pages
given below.

The Tux2 filesystem project has the following goals:

  - Support all the functionality of Ext2
  - Eliminate the need to perform fsck after an interruption   
  - Degrade write performance by no more than 20% versus Ext2
  - Degrade overall performance by no more than 10% versus Ext2
  - Allow an ext2 partition to be mounted as tux2

An experimental prototype of Tux2 has been created for kernel version
2.2.13, and has been used to obtain initial performance measurements,
suggesting that the project goals are indeed achievable.  The Linux
kernel has changed considerably in the intervening nine months since
implementation work began, generally becoming better suited to Tux2's
requirements, and work on the 2.2 version has been stopped in favor of
a new version for the 2.4 kernel series.  Code is expected to be
available for download this fall.  Interested developers can obtain an
early version by contacting me directly.

This work is sponsored by innominate AG for the benefit of the Linux
community, and I would like to take this opportunity to recognize the
generosity of this forward-thinking company, whose goal is to support
and promote the use of open source software in Europe, and to profit
thereby.

There are project pages under construction at:

  http://innominate.org/~phillips/tux2
   http://tux2.sourceforge.net

There is a mailing list for interested developers.  To subscribe, send
a message with the single word 'subscribe' as the subject or body to:

  tux2-dev-request@innominate.org

--
Daniel Phillips

software engineer, innominate AG
daniel.phillips@innominate.de
http://innominate.de 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
