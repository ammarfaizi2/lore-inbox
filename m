Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUJRT6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUJRT6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJRTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:55:55 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:55208 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267713AbUJRTuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:50:50 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 18 Oct 2004 12:50:41 -0700
MIME-Version: 1.0
Subject: Re: Running user processes in kernel mode; Java and .NET support	in kernel
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <4173BC21.24859.11899F91@localhost>
In-reply-to: <1097980064.13433.12.camel@localhost.localdomain>
References: <82fa66380410152111143f75ec@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Why would I care ? I need the MMU for paging and to avoid
> fragmentation of the system. If I have the MMU on then memory
> protection checks are free. 
> 
> Except in 4G/4G mode syscalls are extremely cheap too nowdays.

Yes, but kernel mode support in user programs would allow user mode 
device drivers to do stuff that currently cannot be done at all from user 
space such as handling interrupts and scheduling DMA operations.

Just think about how nice it would be if the kernel level DRI driver 
modules that are currently completely separate from the user space X 
drivers could be all in one place? Then users would no longer have to 
worry about making sure they upgrade their kernel so it has the correct 
kernel module installed at the same time that they upgrade X or get new 
drivers for their X server.

IMHO I am not sure how much speedup you would gain from kernel mode Linux 
for user space programs (it might surprise us, or maybe it isn't much), 
but the ability to support user mode device drivers would be good IMHO, 
especially for graphics.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


