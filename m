Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSLXNLw>; Tue, 24 Dec 2002 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSLXNLw>; Tue, 24 Dec 2002 08:11:52 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:29018 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261723AbSLXNLw>;
	Tue, 24 Dec 2002 08:11:52 -0500
Date: Tue, 24 Dec 2002 14:19:57 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.53] Cannot open root device
Message-ID: <20021224131957.GA549@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some problems booting kernel 2.5.53, it seems to be unable to
find my root fs:

VFS: Cannot open root device "305" or 03:05

The kernel is booted via lilo:

image = /boot/bzImage-2.5.53
        root = /dev/hda5
        label = linux-2.5.53
        read-only

Appending "root=/dev/hda5" or "root=305" at command line doesn't work. I
was able to boot only using root=/dev/ide/host0/bus0/taget0/lun0/part5.

devsfs  is automatically  mounted at  boot, but  appending devfs=nomount
doesn't change anything.

I have also an other problem that can be related to this:

/dev/hda5 on / type ext2 (rw)
mount: /dev/hda6 has wrong device number or fs type reiserfs not supported.
mount: /dev/hda7 has wrong device number or fs type xfs not supported.

Both reiserfs and xfs are compiled as module (yes, I'm using module-init
0.9.5). I can  mount hda6 and  hda7 from the  shell and the  modules are
loaded automatically.

2.5.52 shows the same behaviour, 2.5.49 worked fine. Didn't tried 2.5.50
and 2.5.51.

I'm a bit confused...

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
