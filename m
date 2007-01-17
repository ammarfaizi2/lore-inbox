Return-Path: <linux-kernel-owner+w=401wt.eu-S932541AbXAQQIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbXAQQIg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbXAQQIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:08:36 -0500
Received: from emroute1.ornl.gov ([160.91.4.119]:41514 "EHLO emroute1.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541AbXAQQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:08:35 -0500
X-Greylist: delayed 850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 11:08:35 EST
Date: Wed, 17 Jan 2007 10:54:18 -0500
From: Lawrence MacIntyre <macintyrelp@ornl.gov>
Subject: Hung Port
To: linux-kernel@vger.kernel.org
Message-id: <45AE46AA.7030700@ornl.gov>
Organization: Oak Ridge National Laboratory
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
OpenPGP: id=42228DB2;
	url=http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xD7566FF1
X-Enigmail-Version: 0.94.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last week I had a port (TCP:52557) that was mysteriously unavailable on
my ubuntu machine (running kernel 2.6.15-27-k7 #1 SMP PREEMPT).  If you
tried to bind to it, it was unavailable.  However, nmap (both to
localhost and from an external host) reported the port closed.  fuser,
lsof, and netstat had no record of the port being used.  Our firewall
logs didn't show any unusual traffic to the machine.  Nor did they show
any traffic at all to/from that port on the machine.  After checking
everything I could think of, I rebooted it, and there were no ports that
were unavailable in this way when it came back up.  This morning another
hung port has appeared (TCP:43355).  My best guess is that this is an
ephemeral port that has somehow gotten hung in the kernel somewhere.
Has anyone seen anything like this and/or is there anything else I could
look at to figure it out?
-- 
  Lawrence MacIntyre   865.574.8696   macintyrelp@ornl.gov
                Oak Ridge National Laboratory
Cyber Security and Information Infrastructure Research Group

Protect your digital freedom and privacy, eliminate DRM.
Learn more at http://www.defectivebydesign.org/what_is_drm
