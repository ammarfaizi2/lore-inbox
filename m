Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTKJXao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTKJXao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:30:44 -0500
Received: from houseofdistraction.com ([206.63.251.121]:23314 "EHLO
	houseofdistraction.com") by vger.kernel.org with ESMTP
	id S263267AbTKJXan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:30:43 -0500
Message-ID: <3FB01F7E.7090100@houseofdistraction.com>
Date: Mon, 10 Nov 2003 15:30:06 -0800
From: Jeff Bowden <jlb@houseofdistraction.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.3.1-3 StumbleUpon/1.73
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: percpu_counter_mod not getting into SMP kernel image when ext2/3
 compiled as modules
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.9-test9 (also tried with bk15) I have ext2 and ext3 both 
configured as modules.  When I do "modprobe ext3" it says:

  FATAL: Error inserting ext3 
(/lib/modules/2.6.0-test9-bug-t1/kernel/fs/ext3/ext3.ko): Unknown symbol 
in module, or unknown parameter (see dmesg)

and dmesg says:

  ext3: Unknown symbol percpu_counter_mod

I found one message in the archive 
(http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/0311.html) which 
mentions this problem and includes a proposed fix. The lines from the 
this proposal made it into lib/percpu_counter.c but somehow it seems 
that they are not causing the symbol to end up in the main kernel 
image.  In fact the string "percpu_counter_mod" does not occur in 
vmlinux or in any of the modules other than ext2.ko and ext3.ko.

The kernel in question was compiled with gcc 3.3.1 on an up-to-date 
debian/unstable.  A copy of the exact .config I used can be had from 
http://jlb.changelog.com/config-2.6.0-test9-bug-t1

I am not subscribed to this mailing list.


