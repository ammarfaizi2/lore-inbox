Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbREHMKF>; Tue, 8 May 2001 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbREHMJy>; Tue, 8 May 2001 08:09:54 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:63237 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132057AbREHMJs>;
	Tue, 8 May 2001 08:09:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: kdb wishlist
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 May 2001 22:09:42 +1000
Message-ID: <23270.989323782@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of my kdb wishlist, does anybody fancy writing the code to
add any of these features?  It would be a nice project for anybody
wanting to start on the kernel.  Replies to kdb@oss.sgi.com please.
Current patches at http://oss.sgi.com/projects/kdb/download/

* Change kdb invocation key from ^A to ^X^X^X within 3 seconds.  ^A is
  used by emacs, bash, minicom etc.

* Command history.  Handle up/down/left/right/delete keys.  Each
  kdba_io routine is responsible for recognising the arch specific
  keys, with a common history and editting routine.

* Clean up repeating commands.  Pressing enter at the kdb prompt
  repeats the previous command, no matter what the previous command
  was.  Some commands it makes no sense to repeat (bp in particular),
  for other commands you want to repeat the command but without the
  parameter (md in particular).

* Embed width and count options in md and mm commands.  Some hardware
  requires that accesses be a specific width, this can be achieved by
  setting BYTESPERWORD but it is awkward.  We want md1 to read one
  byte, md2, md4, md8 commands.  All can have a count field, e.g.
  md1c8 reads 8 bytes one at a time.  mm1, mm2, mm4, mm8 to set memory
  no count field.

