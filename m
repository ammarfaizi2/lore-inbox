Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSG1KTn>; Sun, 28 Jul 2002 06:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSG1KTn>; Sun, 28 Jul 2002 06:19:43 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:58261 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S315539AbSG1KTn>; Sun, 28 Jul 2002 06:19:43 -0400
Date: Sun, 28 Jul 2002 18:22:46 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-XFS Mailing List <linux-xfs@oss.sgi.com>
Subject: Unkillable processes stuck in "D" state running forever
Message-ID: <20020728102246.GG1265@leathercollection.ph>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-XFS Mailing List <linux-xfs@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Again I cross-post, and hope that people will accept my apologies. I do
not know if this is a vanilla kernel problem, or something that has to
do with XFS.

I have been noticing problems on two of my boxes here with some
processes somehow getting stuck in "D" state, which cannot be killed
even by a SIGKILL by root, and stay on running forever. I have noticed
the problem, so far, on 2.4.18-xfs and 2.4.19-rc2-xfs kernels.

The 2.4.18-xfs kernel did not have any binary-only modules loaded (like
NVdriver) and aside from the modules from the kernel only had the i2c
and lm-sensors modules. It was compiled using gcc 2.95.4 and was running
on a single Pentium III.

The 2.4.19-rc2-xfs kernel had the NVdriver binary-only module loaded
(coincidentally the same unit I reported kernel BUG reports in
page_alloc.c:91 about earlier), plus kernel modules and the i2c and
lm-sensors modules. It was compiled using gcc 3.1.1 (Debian prerelease)
and was running on a single AMD Duron.

I have not found a pattern to the occurence of these stuck processes.
They don't happen at given intervales, or with only a particular type of
process, or on certain workloads or tasks.

They've happened on everything from X11 (consequently freezing the box),
to the apt-method of dpkg (consequently preventing me from doing any
apt-get installations), to the dhcp3 daemon (consequently preventing new
boxes from getting IP addresses). They've also happened on boxes with
two days uptime, or with 7 days uptime, or with 14.

So far the only "solution" I've found to this problem has been to
reboot.

There is unfortunately absolutely nothing I can find in the logs to help
explain what's going on with these processes. Because I have not figured
out how to reproduce this, I do not know which process to run through
strace or a similar tool to figure out what's going on.

I hope someone can help shed light on this. Thank you very much. I have
upgraded the 2.4.18-xfs box to 2.4.19-rc3-xfs, and will upgrade the
2.4.19-rc2-xfs box to 2.4.19-rc3-xfs as well, and will see if the
problem goes away. If anyone else is experiencing similar "processes
stuck in state 'D'" problems, please do chime in and add your
experiences about the problem.

 --> Jijo

-- 
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
