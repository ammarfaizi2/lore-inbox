Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWCRG0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWCRG0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWCRG0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 01:26:48 -0500
Received: from lexington.centerclick.org ([66.114.92.10]:35512 "EHLO
	lexington.centerclick.org") by vger.kernel.org with ESMTP
	id S1751682AbWCRG0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 01:26:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17435.43034.364906.429948@wellington.i202.centerclick.org>
Date: Sat, 18 Mar 2006 01:26:34 -0500
From: Dave Johnson <dave-linux-kernel@centerclick.org>
To: linux-kernel@vger.kernel.org
Subject: 3ware 6x00 monitor/control utilities broken/dropped since 2.6.10?
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 3ware 6400 controller that I've been using for some 5 years
without problems.  I just upgraded my kernel from 2.6.9 to
2.6.15.6 and now the 3ware provided monitoring/control daemon (3dm) will
no longer talk to the driver in 2.6.15.

It appears that /proc/scsi/3w-xxxx which the daemon relies on was removed
from the driver:

open("/proc/scsi/3w-xxxx", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOENT (No such file or directory)
open("/proc/scsi/3w-xxxx-z", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOENT (No such file or directory)

The problem is I'm already using the latest 3ware utilities (v6.9 for
the 6400).  While the driver does allow access to the array from the
SCSI subsystem and I can use the filesystem, I have no way to monitor
or control it anymore.

Any suggestions besides reverting back to 2.6.9 and staying there?

I'd be happy to use a different monitor/control program if one exists.

-- 
Dave

