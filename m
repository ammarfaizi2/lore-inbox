Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVBACUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVBACUQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVBACUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:20:16 -0500
Received: from sccimhc91.asp.att.net ([63.240.76.165]:62109 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S261498AbVBACUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:20:11 -0500
From: Jay Roplekar <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483 and related {now 2.6.8}
Date: Mon, 31 Jan 2005 20:19:54 -0600
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200501312019.54250.jay_roplekar@hotmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks for giving that a thorough run, memory seems exonerated... yet I
>don't trust this machine at all: have you tried manufacturer diagnostics?

Ouch, that hurts. This is a machine I built myself over three years ago. Ran 
very stably with 2.4.*.  may be  it is the age of the machine.  The  recent 
hardware changes are additions of a dvd writer, a hdd and a pci wireless 
card. Which  seem to work ok until recently. What other diagnostics would 
make sense? 

>> Jan 29 08:25:02 Bad page state at prep_new_page ('X', page c1251ae0)
>> Jan 29 08:25:02 flags:0x20000004 mapping:00006a00 mapcount:0 count:0

>Again, something I've not seen reported before: mapping:00006a00, when
>mapping should be NULL (or at least a pointer into kernel memory).  You
>say message reappeared twice with identical addresses: was that mapping
>the same each time?

Hmm, it is different one time, as shown below.. I guess should have looked 
carefully. Although  it means nothing to me..  FWIW, please  note that in all 
these cases  ndiswrapper (windows driver loader) is being used. Thanks, Jay

Jan 29 08:27:03 localhost kernel: Bad page state at prep_new_page (in process 
'X', page c1253a60)
Jan 29 08:27:03 localhost kernel: flags:0x20000004 mapping:00006a00 mapcount:0 
count:0

Jan 29 08:27:08 localhost kernel: Bad page state at prep_new_page (in process 
'X', page c12965e0)
Jan 29 08:27:08 localhost kernel: flags:0x20000004 mapping:00006600 mapcount:0 
count:0
