Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbUKDPKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbUKDPKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUKDPKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:10:31 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:53701 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262249AbUKDPKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:10:25 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 10:10:23 -0500
User-Agent: KMail/1.7
Cc: Ian Campbell <icampbell@arcom.com>, Jan Knutar <jk-lkml@sci.fi>,
       Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040907.22684.gene.heskett@verizon.net> <1099578240.2856.51.camel@icampbell-debian>
In-Reply-To: <1099578240.2856.51.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041010.23990.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.42.194] at Thu, 4 Nov 2004 09:10:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 09:24, Ian Campbell wrote:
>grep -r sysrq /etc

Gets me a bunch.  The revelant ones would be:
/etc/rc.d/rc3.d/K20iscsi:           if [ -e /proc/sys/kernel/sysrq ] ; then
/etc/rc.d/rc3.d/K20iscsi:               echo "1" > /proc/sys/kernel/sysrq

and
/etc/rc.d/rc.local:# Turn on the magic sysrq keys
/etc/rc.d/rc.local:echo 1 >/proc/sys/kernel/sysrq

But, what about this:
/etc/sysctl.conf:# Disables the magic-sysrq key
/etc/sysctl.conf:kernel.sysrq = 0
which I just commented out...

And this:
/etc/linuxconf/archive/Office/etc/sysctl.conf,v:kernel.sysrq = 0
But everything there is dated early 2001.  I think its filesystem
cruft nowadays, subject to being a space patrol target eventually.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
