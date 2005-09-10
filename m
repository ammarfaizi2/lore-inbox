Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVIJMjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIJMjF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVIJMjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:39:05 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:52914 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1750799AbVIJMjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:39:04 -0400
Date: Sat, 10 Sep 2005 14:39:02 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: read-from-all-disks support for RAID1?
Message-ID: <20050910123902.GA9461@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC on replies)

Hi!

I recently had a case where one disk in a two-disk RAID1 array went
subtly bad, effectively refusing to write to certain sectors without
reporting an error.  Basically, parts of the disk went undetectably
read-only, causing file system corruption that wouldn't go away after
fsck, and all kinds of other fun.

Would it be hard/wise to add an option for RAID1 mode to read from all
devices on a read, and report an error to syslog or simply return an
I/O error if there is a mismatch?  (Or use majority voting and tell
people to use 3-disk RAID1 arrays from now on ;-)


thanks,
Lennert
