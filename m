Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTLWIUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTLWIUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:20:14 -0500
Received: from dukat.upl.cs.wisc.edu ([128.105.45.39]:35513 "EHLO
	dukat.upl.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S265059AbTLWIUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:20:07 -0500
Date: Tue, 23 Dec 2003 02:20:06 -0600 (CST)
From: Ben Srour <srour@cs.wisc.edu>
X-X-Sender: srour@data.upl.cs.wisc.edu
To: linux-kernel@vger.kernel.org
Subject: compiling modules after 2.4.* --> 2.6.0 upgrade
In-Reply-To: <200312230757.40960.andrew@walrond.org>
Message-ID: <Pine.LNX.4.44.0312230211500.28609-100000@data.upl.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm attempting to port a module I wrote for the 2.4 series to 2.6 but I
get the following error when I try and insmod:

	root@dimension# /usr/sbin/insmod gpstest.o
	insmod: error inserting 'gpstest.o': -1 Invalid module format
	root@dimension#

(/sbin/insmod returns:
	insmod: QM_MODULES: Function not implemented
but isnt that a remnant of the 2.4 series module-init-tools?)

/usr/sbin/insmod -v
module-init-tools version 3.0-pre1

/sbin/insmod -V
insmod version 2.4.18
....


I'm guessing this is happening because the module it seems to be compiling
for is 2.4:
	root@dimension# strings gpstest.o
	kernel_version=2.4.9-31
	....
	root@dimension#

I'm using module-init-tools-3.0-pre1, gcc3.0.4, kernel2.6.0


Any help/direction would be appreciated!
Thanks
Ben

-- 
Ben Srour
srour@cs.wisc.edu


