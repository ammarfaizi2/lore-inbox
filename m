Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTIYN0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTIYN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:26:33 -0400
Received: from web40903.mail.yahoo.com ([66.218.78.200]:56758 "HELO
	web40903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261193AbTIYN0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:26:31 -0400
Message-ID: <20030925132630.59015.qmail@web40903.mail.yahoo.com>
Date: Thu, 25 Sep 2003 06:26:30 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: 2.6.0-test broke RPM 4.2 on Red Hat 9 in a VERY weird way
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just discovered a very strange and unusual problem with rpm on my Red Hat 9
laptop running 2.6.0-test. Under 2.4.22-ac2 rpm runs perfectly fine, but when I
run it under 2.6.0-test, it outputs the following errors:

sudo rpm -Uvh alsa-driver-0.9.6-1.fr.i386.rpm
Password:
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages index using db3 - Resource temporarily unavailable (11)
error: cannot open Packages database in /var/lib/rpm
warning: alsa-driver-0.9.6-1.fr.i386.rpm: V3 DSA signature: NOKEY, key ID e42d547b
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages database in /var/lib/rpm
rpmdb: unable to join the environment
error: db4 error(11) from dbenv->open: Resource temporarily unavailable
error: cannot open Packages database in /var/lib/rpm

I have never seen rpm do this before, and it only occurs under 2.6.0-test. It
happens under these specific kernels:

2.6.0-test5-bk10
2.6.0-test5-bk11
2.6.0-test5-mm4

I have not tried -test5-bk12 yet, but I have a feeling that I will get the same
errors. I have checked syslog and dmesg and there are no errors from the kernel;
under 2.4.22-ac2 rpm works perfectly fine, so I don't believe it's file corruption
or filesystem breakage.

Does anyone have any ideas that I can try?

Thanks!

Brad



=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
