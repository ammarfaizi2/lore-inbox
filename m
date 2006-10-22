Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWJVTzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWJVTzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWJVTzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:55:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13806 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751204AbWJVTzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:55:52 -0400
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Avi Kivity <avi@qumranet.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
In-Reply-To: <453B2DDB.3010303@qumranet.com>
References: <4537818D.4060204@qumranet.com>
	 <20061019173151.GD4957@rhun.haifa.ibm.com> <4537BD27.7050509@qumranet.com>
	 <200610211816.27964.arnd@arndb.de>  <453B2DDB.3010303@qumranet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2006 20:56:55 +0100
Message-Id: <1161547015.1919.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-22 am 10:37 +0200, ysgrifennodd Avi Kivity:
> I like this.  Since we plan to support multiple vcpus per vm, the fs 
> structure might look like:

Three times the syscall overhead is bad for an emulation very bad for an
emulation of a CPU whose virtualisation is half baked.

> It's certainly a lot more code though, and requires new syscalls.  Since 
> this is a little esoteric does it warrant new syscalls?

I think not - ioctl exists to avoid adding a billion esoteric one user
syscalls. The idea of a VFS sysfs type view of the running vm is great
for tools however so I wouldn't throw it out entirely or see it as ioctl
versus fs.

