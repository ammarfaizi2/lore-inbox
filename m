Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272377AbTHIO4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272382AbTHIO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:56:06 -0400
Received: from othala.naquadah.org ([213.41.156.228]:7922 "EHLO
	selmak.ipv6.naquadah.org") by vger.kernel.org with ESMTP
	id S272377AbTHIO4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:56:04 -0400
Date: Sat, 9 Aug 2003 16:51:50 +0200
From: Julien Danjou <julien@jdanjou.org>
To: linux-kernel@vger.kernel.org
Subject: Error in raid1 device
Message-ID: <20030809145150.GB4514@selmak.naquadah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just see this today on a machine running 2.6.0-test2-bk7:
Aug  9 16:48:03 abydos kernel: attempt to access beyond end of device
Aug  9 16:48:03 abydos kernel: md1: rw=0, want=4000855256, limit=5863424

Aproximatively 10 times :-/
The result is awful:
s--xrws---  28436 3902563852 2186484323 4286391822 Jan 10  2015 uptime

(yes, uptime is a socket :-/)

Several program seems to be corrupted in /usr/bin (maybe elsewhere also..)

The file system is ext3 and md1 is a raid1 array mounted on /usr.
/dev/md/1             2,8G  2,3G  329M  88% /usr
The IDE controler is an Intel on a P4P800.
00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02)

I have just rebooted on test3, I have the same output at boot time, the
file system seems to be "definitively corrupted".

-- 
Julien Danjou

· http://jdanjou.org                   <julien@jdanjou.org> ·
· GnuPG: 9A0D 5FD9 EB42 22F6 8974  C95C A462 B51E C2FE E5CD ·
