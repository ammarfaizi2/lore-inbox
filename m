Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVAWEei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVAWEei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAWEeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:34:18 -0500
Received: from ORION.SAS.UPENN.EDU ([128.91.55.26]:21694 "EHLO
	orion.sas.upenn.edu") by vger.kernel.org with ESMTP id S261211AbVAWEdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:33:49 -0500
Subject: Re: Trying to fix radeonfb suspending on IBM Thinkpad T41
From: Volker Braun <vbraun@physics.upenn.edu>
To: Antti Andreimann <Antti.Andreimann@mail.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1106450704.10594.52.camel@localhost.localdomain>
References: <1106450704.10594.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 23:33:09 -0500
Message-Id: <1106454789.8309.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no knowledge of the internals of the radeon family, but I am
under the impression that they require some hacks to work around bugs in
the silicon. There is a rather big patch coming, see

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-
rc1/2.6.11-rc1-mm2/broken-out/radeonfb-massive-update-of-pm-code.patch

This patch also rewrites the questionable section in
radeon_pm_setup_for_suspend. I just found it and have not yet built a
new kernel, so I cannot comment on its effectiveness. 

For reference, the power management issues of the T41 have their own
bugzilla entry:

http://bugme.osdl.org/show_bug.cgi?id=3022

On a side note, since kernel 2.6.10 I have not been able to successfully
resume from acpi S3 + radeonfb any more (T41 2379-DJU, radeon mobility
M9) - works under 2.6.9 and 2.6.11-rc1 + vgaconsole. I'm still trying to
isolate the problem/waiting for some of the pm code to settle.

Best,
Volker


