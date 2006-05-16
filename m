Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWEPTbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWEPTbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWEPTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:31:52 -0400
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:53203 "EHLO
	mail.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1751298AbWEPTbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:31:51 -0400
Subject: running only 1 process on 1 cpu
From: fritzsch <fritzsch@cip.physik.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 16 May 2006 21:31:42 +0200
Message-Id: <1147807902.6647.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
i have one process, which i want to run on a cpu (> CPU0). The special
thing here is, that this process is very time critical and  should NOT
be interrupted by anything (cpusets/cpus_allowed would not be enough).
(the process is not doing any system calls and is communicating to the
world by shared memory).
so i wanted to run the process on a CPU1, when all irqs are disabled and
so the process could not be interrupted.


I tried very simple to 

(1) migrate all processes to CPU0 by cpu_set_allowed
(2) gave my process (running on CPU1) the highest priority
(3) run schedule and make sure that the irqs are disables
(disable_irqs()) 
...

but well, it didnt work ...
actually i wanted to ask if this could work and if there is maybe sth
like this already somewhere implemented (or easily adaptable).
thx
patrick



