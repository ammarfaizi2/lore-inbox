Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWH3Iwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWH3Iwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 04:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWH3Iwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 04:52:35 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22959 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750706AbWH3Iwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 04:52:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17653.20935.117426.731854@alkaid.it.uu.se>
Date: Wed, 30 Aug 2006 10:52:23 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: zhiyi huang <hzy@cs.otago.ac.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ultra Sparc T1 port
In-Reply-To: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz>
References: <A2A6BFA6-28FA-4525-8705-31555B5327D2@cs.otago.ac.nz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhiyi huang writes:
 > Hello,
 > I am using a Ubuntu port on Ultra Sparc T1.
 > Linux version 2.6.15-21-sparc64-smp (buildd@artigas) (gcc version  
 > 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP Fri Apr 21 17:04:05 UTC 2006
 > I have installed a module in the kernel. It is a RAM device driver.  
 > When my application calls ioctl on the device (/dev/dsm), I got the  
 > following log message:
 > 
 > Aug 29 11:13:20 info-sf-03 kernel: [    3.603348] ioctl32(manager: 
 > 18821): Unknown cmd fd(3) cmd(80047f00){00} arg(fffc3934) on /dev/dsm
 > 
 > I check my module and found the control has not reached my module  
 > yet. I haven't got much clue why it happened and how to fix the  
 > problem. It works fine on Linux 2.6.8/i386, by the way.
 > Thanks for help:)

There's a separate mailing list for SPARC Linux.

In this case, you probably just forgot to set up a ->compat_ioctl()
method in your device's file ops.

/Mikael
