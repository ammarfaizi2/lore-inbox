Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318324AbSHEHLC>; Mon, 5 Aug 2002 03:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318325AbSHEHLB>; Mon, 5 Aug 2002 03:11:01 -0400
Received: from hmbg-d5144309.dsl.mediaWays.net ([213.20.67.9]:2578 "EHLO
	birnet.org") by vger.kernel.org with ESMTP id <S318324AbSHEHLB>;
	Mon, 5 Aug 2002 03:11:01 -0400
Date: Mon, 5 Aug 2002 09:13:33 +0200 (CEST)
From: Tim Janik <timj@gtk.org>
To: Theodore Tso <tytso@mit.edu>
cc: linux-kernel@vger.kernel.org
Subject: process accounting continues on RO fs
Message-ID: <Pine.LNX.4.21.0208050835100.902-100000@birgrave.birnet.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ted,

i just noted, that with process accounting enabled, /var/account/pacct
is still being written to after it's file system (ext2 here) got
(emergency) remounted read-only. the behaviour is reproducable for me
with at least 2.4.17 and 2.4.19.
of course, fsck (e2fsck 1.27 (8-Mar-2002) here) badly screwes
up with fixing block counts in that situation (if run after the remount
before the next reboot, that is).
for the record, my accounting utils version is 6.3.5.
let me know if you need more information or are unable to reproduce
this behaviour.

---
ciaoTJ



