Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032345AbWLGP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032345AbWLGP5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032346AbWLGP5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:57:42 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:49276 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032345AbWLGP5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:57:41 -0500
Date: Thu, 7 Dec 2006 16:57:40 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 file content corruption on ext3
Message-ID: <20061207155740.GC1434@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one of my systems is running Debian stable with a self-compiled Linux
kernel. On this system, Debian's aptitude binary is started hourly
from cron to check for new packages (including virus scan definition
packages, this is actually the reason for the update running so often).

After updating to 2.6.19, Debian's apt control file
/var/cache/apt/pkgcache.bin corrupts pretty frequently - like in under
six hours. In that situation, "aptitude update" segfaults. When I
delete the file and have apt recreate it, things are fine again for a
few hours before the file is broken again and the segfault start over.
In all cases, umounting the file system and doing an fsck does not
show issues with the file system.

I went back to 2.6.18.3 to debug this, and the system ran for three
days without problems and without corrupting
/var/cache/apt/pkgcache.bin. After booting 2.6.19 again, it took three
hours for the file corruption to show again.

I do not have an idea what could cause this other than the 2.6.19
kernel.

The file system in question is an ext3fs on an LVM LV, which is member
of a VG that only has a single PV, which in turn is on a primary
partition of the first IDE hard disk, hda. The IDE interface is a VIA
Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master
IDE (rev 06). The box is a rented server in a colocation, and I do not
have access to the console or physical access to the box itself.

I'll happily deliver information that might be needed to nail down
this issue. Can anybody give advice about how to solve this?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
