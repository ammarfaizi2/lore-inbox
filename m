Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266154AbUGESGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266154AbUGESGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUGESGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:06:11 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:17291 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S266154AbUGESF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:05:56 -0400
Subject: getting /dev/<DEVICE> from (MAJOR, minor)
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
Reply-To: TazForEver@free.fr
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jul 2004 20:05:50 +0200
Message-Id: <1089050750.20203.12.camel@athlon>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for my english)
(sorry if this is not the good place to ask, but i didn't get any anwser
on comp.os.linux.development.system)

	Hi, i'd like to retrieve iostats from /sys in a userspace program. My
library has a function fsusage(mount_point) which is implemented using
statvfs(), etc. I'd like to extend it to provide information described
in linux/documentation/iostats.txt : read/write sectors (? the
documentation doesn't say what is a sector, am i wrong if i assume it's
512B on every arch and filesystem ?).

	So i need to know the device name to browse /sys/block to the 'stat'
file. I would like to avoid getmntent() (retrieving the device name from
the mount table). I was thinking about retrieving the (major, minor)
with stat() in order to get the devname. But i didn't find any quick way
to get it (readdir()-ing /dev is stupid, i'd better use getmntent()).

How can i retrieve the devname with its (M, m) ?

	I want to avoid getmntent, not for performance issue (should not be
critical) but for internal reasons. Btw, even if i finally read the
mnttab, i'm interested in the answer.

thank you.

-- 
Benoît Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr

