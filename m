Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWD1QM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWD1QM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWD1QM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:12:29 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:21917 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030470AbWD1QM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:12:27 -0400
From: Vernon Mauery <vernux@us.ibm.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [BUG 2.6.16-rt18] machine stops before reboot
Date: Fri, 28 Apr 2006 09:12:24 -0700
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604280912.24578.vernux@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

On the Intellistation and LS-20 configuration I just reported the irqpoll bug 
about, if we don't use irqpoll to boot and it actually boots up and things 
seem to be working fine, when we go to reboot, it doesn't ever completely 
shut down:

The system is going down for reboot NOW!
INIT: Sending processes the TERM signal
Stopping cups-config-daemon: [  OK  ]
Stopping HAL daemon: [FAILED]
Stopping system message bus: [  OK  ]
Stopping atd: [  OK  ]
Stopping cups: [  OK  ]
Shutting down xfs: [  OK  ]
Shutting down console mouse services: [  OK  ]
Stopping sshd:[  OK  ]
Shutting down sendmail: [  OK  ]
Shutting down sm-client: [  OK  ]
Shutting down smartd: [  OK  ]
Stopping xinetd: [  OK  ]
Stopping acpi daemon: [  OK  ]
Stopping crond: [  OK  ]
Stopping NFS statd: [  OK  ]
Stopping portmap: [  OK  ]
Shutting down kernel logger: [  OK  ]
Shutting down system logger: [  OK  ]
Shutting down interface eth0:  [  OK  ]
Shutting down loopback interface:  [  OK  ]
Starting killall:  [  OK  ]
Sending all processes the TERM signal...

And it gets stuck here.  That machine is not dead or hung.  I can type stuff 
and it shows up on the terminal, but it does not seem to be running anything.  
I can reboot it with the sysrq keys.

I tested this against 2.6.16-rt16 and I haven't seen this problem after about 
6 reboots.  So I think this is a regression.

--Vernon

