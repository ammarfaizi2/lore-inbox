Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993136AbWJUQy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993136AbWJUQy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993143AbWJUQyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:54:54 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:12766 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S2993136AbWJUQyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:54:32 -0400
Message-ID: <453A52CE.80605@wolfmountaingroup.com>
Date: Sat, 21 Oct 2006 11:03:10 -0600
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 3Ware delayed device mounting errors with newer 9500 series adapters
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adam,

We have been getting 3Ware 9500 series adapters in the past 60 days 
which exhibit a delayed behavior during mounting of FS from
/etc/fstab.   The adapters older than this do not exhibit this behavior. 

During bootup, if the driver is compiled as a module rather than in 
kernel, mount points such as /var in fstab fail to detect the devices
until the system fully boots, at which point the /dev/sdb etc. devices 
showup.  It happens on both ATA cabled drives and drives
cabled with multi-lane controller backplanes.

The problem is easy to reproduce.  Install ES4, point the /var directory 
during install to one of the array devices in disk druid, and after
the install completes, /var/ will not mount during bootup and all sorts 
of errors stream off the screen.  I can reproduce the problem
with several systems in our labs and upon investigating the adapter 
revisions, I find that adapters ordered in the past 60 days exhibit
the problem.   Compiling the driver in kernel gets around the problem, 
indicating its timing related.

Jeff
