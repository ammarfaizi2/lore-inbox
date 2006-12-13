Return-Path: <linux-kernel-owner+w=401wt.eu-S964920AbWLMMwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWLMMwm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWLMMwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:52:42 -0500
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:56315 "EHLO smtp2.it.da.ut.ee"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964920AbWLMMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:52:41 -0500
X-Greylist: delayed 1593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:52:40 EST
Date: Wed, 13 Dec 2006 14:11:04 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: V4L2: __ucmpdi2 undefined on ppc
Message-ID: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  MODPOST 618 modules
WARNING: "__ucmpdi2" [drivers/media/video/v4l2-common.ko] undefined!

This 32-bit ppc architecture, using gcc version 4.1.2 20061115 
(prerelease) (Debian 4.1.1-21). .config below if important.

__ucmpdi2 seems to be 64-bit comparision. gcc seems to use it for switch 
statements on 64-bit values.

drivers/media/video/v4l2-common.c::v4l2_norm_to_name seems to be one 
such switch statement - type of id is v4l2_std_id which is 64-bit.

Should ppc have __ucmpdi2 defined in arch-specific lib? Some other 
architectures seem to implement it (arm, arm26, frv, h8300).

-- 
Meelis Roos (mroos@linux.ee)
