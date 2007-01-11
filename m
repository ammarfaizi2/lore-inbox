Return-Path: <linux-kernel-owner+w=401wt.eu-S1751400AbXAKSc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXAKSc1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAKSc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:32:27 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:58529 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXAKSc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:32:26 -0500
Date: Thu, 11 Jan 2007 10:32:37 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Akula2 <akula2.shark@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
Message-Id: <20070111103237.16066096.randy.dunlap@oracle.com>
In-Reply-To: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 16:30:12 +0530 Akula2 wrote:

> Hello All,
> 
> I did build  2.6.20-rc4 kernel, result is panic. Am getting the
> similar error for 2.6.19.2 too!
> Here is the box info:-
> 
> [sukhoi@Typhoon ~]$ uname -a
> Linux Typhoon 2.6.18-1.2868.fc6 #1 SMP Fri Dec 15 17:32:54 EST 2006
> i686 i686 i386 GNU/Linux
> 
> PS: I did sent an e-mail with attached picture taken by the digital
> camera, but it seems mail got filtered out before listing on the LKML.
> Are there any restrictions for attachments?

Size cannot be > 100 KB (and message cannot be html).
If photo size is > 100 KB, can you post it on the web somewhere?
(or email it me)

> Error messages:
> 
> mount: could not find file system  '/dev/root'
> setuproot: moving /dev failed: No such file or directory
> setuproot: error mountng /proc : No such file or directory
> setuproot: error mountng /sys : No such file or directory
> switchroot: mount failed: No such file or directory
> 
> Could you please give a pointer on this panic? I did refer to gdb to
> debug, it didn't help much. Any clues here how to proceed from here?

Did some other previous kernel versions work/boot for you?
With the same config file?

It looks like your new kernel doesn't have a driver for the boot
device, or the initrd does not have that driver.

> Here is the .config file of 2.6.20-rc4:-
[removed]

---
~Randy
