Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVELLce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVELLce (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 07:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVELLcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 07:32:32 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:38369 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S261461AbVELLcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 07:32:24 -0400
Subject: 2.4.20: pids disappear & reappear in /proc
From: Paolo Campanella <paolo@mighty.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1115897555.22584.1981.camel@paololt.cpt.dom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 May 2005 13:32:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I have a dual-Xeon Intel SMP box running kernel 2.4.20-20.9 (RH9, custom
build enabling some ACPI options etc).

Recently, after a reboot, I've started seeing processes disappear &
reappear in ps output. The problem seems to be in /proc itself, e.g.:

[root@za /]# cat /var/run/httpd-ssl.pid
898
[root@za /]# ls /proc/ | grep 898
[root@za /]# ls /proc/898/
cmdline  cpu  cwd  environ  exe  fd  maps  mem  mounts  root  stat 
statm  status

Process 898 is a 1.3 Apache daemon, so no threading. If I check back
later, this process might have reappeared in ps, but some other process
might have disappeared. Also, some PIDs are duplicated in /proc, but
this duplication comes and goes.

I've done lots of checking for signs of rootkits & exploits, and have
found nothing so far. Maybe hardware failure? Any suggestions welcome.


Thanks

Paolo


