Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTF1Uhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbTF1UgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:36:23 -0400
Received: from arbi.Informatik.uni-oldenburg.de ([134.106.1.7]:56594 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE") by vger.kernel.org with ESMTP
	id S265401AbTF1UgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:36:05 -0400
Subject: Patch 2.4.21 use propper type for pid -II
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Jun 2003 22:50:20 +0200 (MEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19WMeK-000CqW-00@grossglockner.Informatik.Uni-Oldenburg.DE>
From: "Walter Harms" <Walter.Harms@Informatik.Uni-Oldenburg.DE>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi liste,
this is a small patch to fix functions that do not use the 
correct type for pid. daniele bellucci and i have worked this 
out. 

walter

692c692
< static int kill_something_info(int sig, struct siginfo *info, int pid)
---
> static int kill_something_info(int sig, struct siginfo *info, pid_t pid)
1014c1014
< sys_kill(int pid, int sig)
---
> sys_kill(pid_t pid, int sig)
1031c1031
< sys_tkill(int pid, int sig)
---
> sys_tkill(pid_t pid, int sig)
1058c1058
< sys_rt_sigqueueinfo(int pid, int sig, siginfo_t *uinfo)
---
> sys_rt_sigqueueinfo(pid_t pid, int sig, siginfo_t *uinfo)
-- 
