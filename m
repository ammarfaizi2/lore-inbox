Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVEWUiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVEWUiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVEWUiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 16:38:15 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:6826 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261953AbVEWUiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 16:38:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dFWBpvqSI2gzlNb9DdOOPC+xUzANb204/8wbQlTiVNRK+5FjBNEIWJ5IVQvcOyt/naJtbc2P3ff8KV26RtnMYGRI1ZqN4paUZpYIRFQDONL0bkdJbjrxRfhCDdH1qfZIjLIb0zpSOc+Zk864SbytKq/GfZV9ojDY6t9riHn4YWM=
Message-ID: <d3a6bba005052313382d7a81a4@mail.gmail.com>
Date: Mon, 23 May 2005 13:38:05 -0700
From: Anil Kumar <anilsr@gmail.com>
Reply-To: Anil Kumar <anilsr@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: kernel BUG at pageattr:107
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting the following error message as part of stack trace. 
I have a system with > 4G mem with RHEL4 x86_64. I installed the OS
and when I did the reboot, the system failed with a stack trace with
errors as follows:

Intializing hardware.....
kernel BUG at pageattr:107
Invalid operand:0000 [1] SMP
Modules linked in: hw_random tg3 floppy sd_mod aic79xx(U) scsi_mod
dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod
pid: 1217,comm:modprobe....
..............
................
...............
RIP ...{__change_page_attr+1039}
/etc/rc.d/rc.sysinit: line 167: 1217 Segmentation fault modprobe $1
>/dev/null 2>&1

I wanted to know if aic79xx driver is having some problems or is it
kernel/scsi subsystem. I don't see the stack trace pointing to aic79xx
driver at all.

Also, the above issue is only for > 4G mem.

Thanks in advance for the help.

with regards,
   Anil
