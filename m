Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbUKTKmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbUKTKmO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUKTKmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:42:13 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:28168 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261676AbUKTKlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:41:46 -0500
Date: Sat, 20 Nov 2004 11:41:41 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Len Brown <len.brown@intel.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       David Shaohua <shaohua.li@intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.28 breaks lm_sensors
Message-Id: <20041120114141.3e0f5f47.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, hi all,

We have been having reports that recent changes in the ACPI subsystem of
the Linux 2.4 kernel are breaking lm_sensors on a fairly large number of
systems. In particular, 2.4.28 is affected.
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1761
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1819
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1820

I did not report earlier because I thought the problem would be fixed by
the ACPI folks before 2.4.28 would be released. Unfortunately it wasn't.

The problem is already known, was reported for 2.6 kernels 4 months ago
and fixed there by David Shaohua. See this kernel bug report for the
detail of symptoms and the solution:
http://bugzilla.kernel.org/show_bug.cgi?id=3049

Applying the proposed patch to a 2.4.28 kernel make lm_sensors work
again on affected systems, while not causing trouble to unaffected ones
as far as I can tell.

Len, David, any reason not to apply the same fix to the 2.4 tree?

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
