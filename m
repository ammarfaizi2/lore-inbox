Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUDJGXG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 02:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUDJGXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 02:23:06 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:10093
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261947AbUDJGXB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 02:23:01 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
To: "'Feldman, Scott'" <scott.feldman@intel.com>,
       "'Brown, Len'" <len.brown@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: [BUG][2.6.5 final][e100/ee100pro] NETDEV_WATCHDOG Timeout - Related to i2c interface?
Date: Sat, 10 Apr 2004 02:23:06 -0400
Message-ID: <000001c41ec4$5b937430$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF5FB7@orsmsx402.jf.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [69.196.108.95] using ID <shawn.starr@rogers.com> at Sat, 10 Apr 2004 02:21:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, did disable ACPI but still get these errors. I have noticed that if I
start loading/unloading any i2c drivers I start getting eth0 timeouts....the
question is why?

coredump kernel: i2c_adapter i2c-2: Transaction (post): CNT=08, CMD=3a,
ADD=50, DAT0=3e, DAT1=00
Apr 10 01:56:44 coredump kernel: i2c-core: unregister_driver - looking for
clients.
Apr 10 01:56:44 coredump kernel: i2c_adapter i2c-2: examining adapter
Apr 10 01:56:44 coredump kernel: i2c-core.o: detaching client lm80:
Apr 10 01:56:44 coredump kernel: i2c-core.o: detaching client lm80:
Apr 10 01:56:44 coredump kernel: i2c-core: driver unregistered: lm80
Apr 10 01:56:48 coredump kernel: i2c_adapter i2c-2: Adapter unregistered
Apr 10 01:56:48 coredump kernel: i2c_adapter i2c-2: adapter unregistered
Apr 10 01:56:55 coredump kernel: eth0: wait_for_cmd_done timeout!
Apr 10 01:56:55 coredump kernel: Command 00ff never accepted (201 polls)!
Apr 10 01:56:55 coredump kernel: Command 0006 was not accepted after 20001
polls!  Current status ffffffff.
Apr 10 01:56:55 coredump kernel: Command 00ff never accepted (201 polls)!
Apr 10 01:56:55 coredump kernel: Command 0060 was not accepted after 20001
polls!  Current status ffffffff.
Apr 10 01:56:55 coredump kernel: eth0: wait_for_cmd_done timeout!
Apr 10 01:56:55 coredump kernel: Command 00ff never accepted (201 polls)!
Apr 10 01:56:55 coredump kernel: Command 0001 was not accepted after 20001
polls!  Current status ffffffff.
Apr 10 01:56:55 coredump kernel: Command 00ff never accepted (201 polls)!
Apr 10 01:56:56 coredump kernel: Command 0070 was not accepted after 20001
polls!  Current status ffffffff.
Apr 10 01:56:56 coredump kernel: eth0: wait_for_cmd_done timeout!
Apr 10 01:57:27 coredump last message repeated 26 times
Apr 10 01:57:29 coredump last message repeated 3 times

-----Original Message-----
From: Feldman, Scott [mailto:scott.feldman@intel.com] 
Sent: Wednesday, April 07, 2004 02:31 PM
To: Brown, Len; Shawn Starr
Subject: RE: [BUG][2.6.5 final][e100] NETDEV_WATCHDOG Timeout - Was not a
problem with 2.6.5-rc3


> >Shawn, try turning off ACPI for interrupt routing.  Load the kernel
> >with the kernel parameter "noapci" set.
> 
> You mean "acpi=off", or "pci=noacpi".  If either of these fix
> the problem, please let me know.  (and send me the dmesg and 
> /proc/interrupts for both cases)

Yes, sorry.  Can't believe I posted that to lkml.  Oh well.

-scott

