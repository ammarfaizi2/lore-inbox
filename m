Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTHXW54 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbTHXW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 18:57:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:40615 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261329AbTHXW5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 18:57:55 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6.0-test4][ACPI] STR, STD returns immidiately
Date: Sun, 24 Aug 2003 15:37:54 -0700
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241537.54494.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I do 
echo mem > /sys/power/state
or
echo disk > /sys/power/state

it returns in a second without any effect and in sysslog I get this:

Aug 24 15:23:39 bologoe kernel: Stopping tasks: 
===============================================================================================|
Aug 24 15:23:39 bologoe kernel: Restarting tasks... done
Aug 24 15:23:40 bologoe modprobe: FATAL: Module /dev/apm_bios not 
found.

Am I supposed to compile in APM support? I do not think so...

In -test3 this used to work in a sense - S3 was indeed putting the 
machine into sleep state ( but was unable to resume ). Swsusp was 
also working somewhat althought had huge issues...

I'll compile with ACPI debug on in case that may give me any more 
info...

Fedor.
