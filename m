Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277849AbRJLT6N>; Fri, 12 Oct 2001 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278106AbRJLT6D>; Fri, 12 Oct 2001 15:58:03 -0400
Received: from m3d.uib.es ([130.206.132.6]:9149 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S277849AbRJLT5q>;
	Fri, 12 Oct 2001 15:57:46 -0400
Date: Fri, 12 Oct 2001 21:58:16 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.10-ac1 hard lockup (APM+nvidia related) and reiser adds ^@
Message-ID: <Pine.LNX.4.33.0110122137300.7111-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I know... I must complain to nvidia, but it happens only with this
kernel, so I report it just in case.


Doing an apm -s with the nvidia module loaded, the kernel locks hard.
With Linus kernel, the nvidia just rejects the suspend:

kernel: NVRM: avoiding suspend request, don't want to shutdown!!


There is no logs, ctrl-alt-print doesn't work and a ping doesn't neither.
It's strange than the machine locks again next reboot, only avoided cold
reboot.

If I kill all xdm/X processes and rmmod nvidia modules, apm -s it works
nicely.

During these tests, I realised that reiserfs still added funny chars to
log files after a reboot. Thousands of "^@" in all syslog files (hope only
there...).

OTH, I am finding these kernel errors since vanilla 2.4.10:

Oct 12 21:35:32 linux kernel: mtrr: no MTRR for f0000000,2000000 found


Hope this helps.

Regards,

--ricardo

