Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTG2PbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271837AbTG2PbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:31:21 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:50829 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S271824AbTG2PbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:31:15 -0400
Date: Tue, 29 Jul 2003 11:31:14 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-bk3 phantom I/O errors
Message-ID: <20030729153114.GA30071@washoe.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just want to confirm that problem described by Sander
http://marc.theaimsgroup.com/?l=linux-kernel&m=105935020525253
persist on my system since test1-bk2 version as well. And it reveals
itself usually under some specific load of hdd I/O - in my case
usually it is running 'dselect' or 'dpkg -i' with an attempt to install/remove
packages. Then software says something about error in some data file and
syslog bears the signs of errors:
Buffer I/O error on device hda2, logical block 3861502
Buffer I/O error on device hda2, logical block 3861504
Buffer I/O error on device hda2, logical block 3861506

My system is laptop vaio PCG-P505TS running Debian unstable
Linux kernel 2.6.0-test2

I provide links (to don't thrust the mailing list) to my 
.config: 
http://www.onerussian.com/linux.bug/config-2.6.0-test2

dmesg:
http://www.onerussian.com/linux.bug/dmesg.log

dmesg bears also signs about 
buffer layer error at fs/buffer.c:416
Call Trace:
 [<c0154f30>] __find_get_block_slow+0x80/0xe0
 [<c0155f51>] __find_get_block+0x91/0xf0

which I've not mentioned before so I don't know if they are relevant to
the problem

Thanx for your help/support

                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
