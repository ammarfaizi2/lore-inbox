Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJSRAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJSRAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVJSRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:00:49 -0400
Received: from smtpproxy1.mitre.org ([192.160.51.76]:16599 "EHLO
	smtp-bedford.mitre.org") by vger.kernel.org with ESMTP
	id S1751154AbVJSRAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:00:48 -0400
Subject: 26 ways to set a device driver variable from userland
From: Rick Niles <fniles@mitre.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:00:45 -0400
Message-Id: <1129741246.25383.23.camel@gnupooh.mitre.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 17:00:46.0414 (UTC) FILETIME=[A60CDEE0:01C5D4CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are so many ways to set a configuration value in a device driver. I'm wondering
which are "recommended" methods. I'm looking for some sort of guidance when writing a
new driver.  I kinda assume this is a FAQ, but I didn't see it anyway, maybe it should
be added to the FAQ.

OK there might not be 26 ways, but there's a few major ones. I'm thinking in term of
char devices so some of these might not apply to block and network drivers.

(1) ioctl, probably the oldest.
(2) use read/write to a special configuration-only /dev file (e.g. /dev/dvb)
(3) /proc filesystem
(4) sysfs
(5) module load-time command line options.

I understand that flexibility is a good thing, but some guidance would be helpful.

I sorta got the idea that /proc is "out" this year and sysfs is the "in" thing, but
what about the others?  Would you say that (2) should be be discouraged?  Did anyone
tell the DVB people that? Or maybe more is better, that is, a good driver should
allow for ALL of the above! (OK, yeah that was flame bait.)  Should EVERY variable
that can be modified by say sysfs also be settable by insmod command line?

Any guidance would be greatly appreciated,
Rick Niles.






