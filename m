Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSB0RyZ>; Wed, 27 Feb 2002 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292846AbSB0RyF>; Wed, 27 Feb 2002 12:54:05 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:37637 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S292841AbSB0Rx4>;
	Wed, 27 Feb 2002 12:53:56 -0500
Message-Id: <200202271753.KAA37749@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: Possible IDE related crash on 2.4.18-rc4?
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2002 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Wed, 27 Feb 2002 10:53:29 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having what seems to be some sort of IDE related crash when I run
2.4.18-rc4.  The computer is a Dell Inspiron 5000e laptop, which is a
PIII 600, 384MB ram, Intel PIIX4 IDE controller (440BX), and an
IBM-DJSA-230 30GB laptop disk.  The disk is partitioned into reiserfs
(29GB) and swap (386MB).

The machine will appear to work fine, but then the disk will spindown
and immediately restart, then the drive light stays on and the machine
is hung solid.  It will not respond to SysRq, or anything other than
holding the power button down until it turns off.  The last time the
disk restarted I noticed that it made similar seeking noises to what
it makes when being powered on.  It is NOT crashing when making that
IBM click-boing noise.

Obviously this may be a hardware related problem, but IBM's drive
fitness test reports the drive to be OK, and I have not had the
problem when using kernels <= 2.4.17 (even after observing the problem
with 2.4.18).  No IDE errors appear in the log before the crash.

The problem happens both when using noflushd and with noflushd
disabled.  The lockups have all occured during low disk activity, but
95% of the time disk activity is low, so this may just be a
coincidence.

I would be happy to privide any further information that would be
useful in debugging this problem, but I am not sure how to provide
useful diagnostics for such a total and sudden lockup.

As long as I am posting IDE problems... On a different computer, every
time the machine boots I get the errors
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
repeated 4 times.  hdc is an IBM-DTLA-307045 attached to an Intel
PIIX4 controller (440BX).  IBM's drive fitness test does not report
any errors, and I have no other errors or difficulties in using the
drive.  Should I be concerned?

--
Thanks,
Jeff Lessem.
