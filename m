Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTLSJt1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 04:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTLSJt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 04:49:27 -0500
Received: from mail.velocity.net ([208.3.88.4]:7600 "EHLO mail.velocity.net")
	by vger.kernel.org with ESMTP id S262188AbTLSJtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 04:49:25 -0500
Subject: [2.4] Server stops serving nfs files (possibly ext3 or quota
	related)
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071827364.1518.39.camel@rock.dale.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 04:49:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

I'm not sure where to start tracking this down so this seems like the
best place.  I have a decently loaded server with the following
configuration:

2.4.22 custom compiled kernel (all drivers static)
2 x 1.3Ghz P3 (ServerWorks Chipset)
2GB ECC DDR ram
Adaptec aacraid controller card
7 SCSI disks in a hardware array
D-link gigabit ethernet
330GB ext3 filesystem with 128MB journal (enlarged after problem
	appeared)
OS (RH7.3 currently) is on separate software MD devices and SCSI disks.
/aac0/users/home mounted on /home using -o bind

Every so often (this last time had a span of just over a week) the
server will stop writing/reading nfs files to its clients (approx 8). I
couldn't test this most recent time, but as of last time files could
still be written locally to the nfs exported array.

This has happened since install using 2.4.18-acX (-ac needed for new
style quotas at the time) and is still happening as of 2.4.22.  The
server has been upgraded to 2.4.23 but has only been up a few hours.

I'm attaching a pslist at the time of reboot.  The loadavg was somewhere
in the mid 30s.  If you'll notice, quite a few scripts are stuck in D
state.  find_over_quota.sh (spawns repquota) runs every quarter hour,
and remove_old_junkmail.sh (spawns the find stuck in D) runs 4 times per
day.  It seems heavy disk IO can cause it, but it's hard to tell.

Please do not hesitate to contact me for additional information.

Regards,

Dale Blount

