Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbTLHNSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTLHNSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:18:10 -0500
Received: from hastur.physics.ox.ac.uk ([163.1.243.65]:22694 "EHLO
	janus.physics.ox.ac.uk") by vger.kernel.org with ESMTP
	id S265397AbTLHNSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:18:07 -0500
From: Tim Stadelmann <stadelmann@physics.ox.ac.uk>
Organization: University of Oxford
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Dec 2003 13:12:58 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312081312.58472.stadelmann@physics.ox.ac.uk>
Subject: Dell Laptop APM problems/noise
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: stadelmann@physics.ox.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I observe the same power supply (?) noise as Jean-Marc on my Dell Latitude 
C600 with 2.6.0-test10 and -test11, if APM is enabled and the kernel is 
allowed to tell the BIOS that the CPU is idle.

Some remarks, which I hope may be helpful:

- in 2.6, APM idle calls produce the noise, but do not conserve power.  This 
could be either because the call fails to have the desired effect, or because 
whatever causes the oscillation uses so much power that the effect is offset.  
Disabling idle calls avoids the oscillation, but reduces the battery life 
dramaticall if compared with 2.4 kernels or 2.6 using ACPI.

- unlike Jean-Marc, I do not see the problem when using ACPI. Battery life is 
comparable to 2.4 with APM enabled. (of course, suspend does not work, but 
that's a different story...)

- with 2.4 kernels, APM *does* work as expected. No oscillation happens, and 
the battery life is prolonged significantly when allowing idle calls. 
Something relevant must have changed.


					Regards,

					Tim Stadelmann

PS: please CC questions and remarks to my personal address

