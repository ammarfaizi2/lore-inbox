Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTLUD0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 22:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLUD0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 22:26:16 -0500
Received: from main.gmane.org ([80.91.224.249]:36781 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261974AbTLUD0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 22:26:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Firewire/sbp2 troubles with Linux 2.6.0
Date: Sun, 21 Dec 2003 04:26:11 +0100
Message-ID: <yw1x8yl66ecs.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ZkylVM/zzj9A2/w3J7V9UJ+rcMI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having some trouble connecting a Firewire hard disk box to a
laptop running Linux 2.6.0.  The disk is correctly detected when
connected, and can be mounted.  The problems start when I try to read
large files from the disk.  It will start off reading at about 10
MB/s, which seems a bit slow for Firewire.  The disks I've used are
capable of much more.  That's not the real problem, though.  After a
little while, sometimes as little as 1 MB, sometimes after about 50
MB, the reading will stall and this message is printed in the kernel
log:

ieee1394: sbp2: aborting sbp2 command
0x28 00 03 6f d2 f1 00 00 f8 00 

After maybe 30 seconds, reading resumes with a few MB, then stops
again, etc.  By setting max_speed=0 to sbp2 limiting the speed the
interval between the stalls becomes longer.  Other options seem to
have no effect to this problem.

The hex codes printed vary a bit.  Some of the ones I've seen are

0x28 00 03 30 00 11 00 00 10 00 
0x28 00 03 37 82 81 00 00 10 00 
0x28 00 03 37 a2 89 00 00 10 00 
0x28 00 00 00 f0 10 00 00 f8 00 
0x28 00 03 65 be 21 00 00 f8 00 
0x28 00 03 65 d1 29 00 00 f8 00 
0x28 00 03 6f d2 f1 00 00 f8 00 
0x28 00 03 74 b5 71 00 00 f8 00 
0x28 00 03 76 aa e9 00 00 08 00 
0x28 00 03 79 48 b9 00 00 f8 00 

Writing to the disk works without any problems, except that the
throughput is only about 10 MB/s.

I'd appreciate if someone could enlighten me about what's going on.
Is there anything I can do to gather more information about the
problem?

-- 
Måns Rullgård
mru@kth.se

