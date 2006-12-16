Return-Path: <linux-kernel-owner+w=401wt.eu-S1753682AbWLPNZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbWLPNZO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbWLPNZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:25:13 -0500
Received: from neelix.mvwa.de ([212.223.129.99]:57068 "EHLO neelix.mvwa.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbWLPNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:25:12 -0500
X-Greylist: delayed 1511 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 08:25:12 EST
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Christian Kuhn <lollingola@lollingola.de>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061215023014.GC2721@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 13:59:52 +0100
Message-Id: <1166273992.14760.63.camel@luna.lollingola.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, den 14.12.2006, 20:30 -0600 schrieb Michal Sabala:
> I am observing processes entering uninterruptible sleep apparently due
> to an unrelated application using mmap over nfs. Applications in
> "uninterruptible sleep" hang indefinitely while other applications
> continue working properly.
> 

I have a similar issue that seems to be related to this. If I start a
copy process to a nfs mount, this leads to one other process starving
for a while.

This can be reproduced with vanilla 2.6.17,18,19 and 19.1 by starting a
cp to a nfs share and running a local kernel untar at the same time.
After some seconds the tar hangs for arbitrary time. The system is
stable as long as nfs is not used.

Neither logs nor dmesg show anything of interest.

I have already stripped down my (not tainted) x86_64 kernel as far as I
could, this is a amd athlon X2 with a nforce chipset, ubuntu edgy eft
and gentoo. I have tested the usual subjects, disabled smp, apic, acpi,
preemption, some other nic, no X and such.

I will provide any information needed to track this down. But I am not a
kernel hacker and will need advice on how to do this.

Thank You,
Christian

