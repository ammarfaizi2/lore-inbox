Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUB0Uye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUB0Uye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:54:34 -0500
Received: from outbound01.telus.net ([199.185.220.220]:53957 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S263104AbUB0Uyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:54:32 -0500
Subject: Re: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first
	use in this function) 2.6.3-bk3
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077915448.5669.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 27 Feb 2004 13:57:28 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I just saw your questions on LKML about this problem.  The current
status is that the problem (for me) still exists (but a solution is in
progress).  The initial problem was that the kernel build failed.  Both
Ben Collins' and Dave Jones' solutions fixed that problem and the build
process is successful, but my external firewire drives weren't working. 
Ben suspected IEEE1212 detection wasn't working and sent me csr_dump.  I
ran it and it confirmed that not all of my hardware rom is being read
(the rom in the device, not in the 1394 controller) and so devices
aren't being detected.  
Ben contacted Steve Kinneberg (who contacted me).  I sent Steve a
(really ugly hack) of csr_dump to try and display all of the rom, but
there are still quadlets not being detected.  I don't have IEEE1212 spec
sheets and am not familiar with the protocol, but Steve said that a CSR
(configuration and status rom) node is missing from the ieee1212 root
directory for my hard drives, and there is a gap in the rom data.  Steve
is working on a updated csr_dump and hoped to have it finished this
weekend.  I would suspect that anyone with Oxford Semi FW900 controllers
would have the same problem (certainly anyone with same rom).  I have a
sony camera connected  to the 1394 bus also, and it gets detected
perfectly.  

Bob

