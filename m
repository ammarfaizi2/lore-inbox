Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbTAJQwf>; Fri, 10 Jan 2003 11:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbTAJQwe>; Fri, 10 Jan 2003 11:52:34 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:14988 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S265378AbTAJQw1>; Fri, 10 Jan 2003 11:52:27 -0500
To: linux-kernel@vger.kernel.org
Subject: Linus BK tree crashes with PANIC: INIT: segmentation violation
From: Derek Atkins <warlord@MIT.EDU>
Date: 10 Jan 2003 12:01:10 -0500
Message-ID: <sjmlm1t5489.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to get a current 2.5 kernel up and running but I've
hit a wall.  When I run my machine with a current kernel I get the
following message to my terminal, repeated ad nausium:

  PANIC: INIT: segmentation violation at 0x804a08c (code)! sleeping for 30 seconds!

I've been working off of Linus' BK repository and was finally able to
get a "working" kernel when I backed up to approximately 2002-12-30
(which is sometime between 2.5.53 and 2.5.54).  That kernel works just
fine.

Sometime between December 30 and January 1 a patch was added that
causes the kernel to go into an infinite loop of Oopses.  Then
sometime later the behavior changed to the INIT problem I mentioned
above.

Does anyone have any clue how to deal with this?  I can assure you
that it is NOT a hardware problem (otherwise why would the same
hardware work with 2.4 and 2.5.53+?)  The only change being made here
is the kernel.

I have not had a chance to back out each and every ChangeSet
individually between Jan1 and Dec30 to figure out what was causing the
stream of oopses -- nor am I even confident that that would lead me to
a solution for the "PANIC: INIT" problem.

In case anyone cares, the most recent ChangeSet from my
confirmed-working (2.5.53+) tree is labeled:

  1.1004 02/12/30 13:47:09 torvalds@home.transmeta.com +2 -0
  Make x86 platform choice strings more easily selectable

However I have not guaranteed that this is the Changeset just before
it failed (I'm not enough of a bk guru to figure out how to pull down
one changeset at a time).

Any advice would be greatly appreciated....  I'd be more than happy to
try things out for people if you have tests you want me to run.

Thanks!

-derek

PS: I am not subscribed directly so please CC me on your replies.

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
