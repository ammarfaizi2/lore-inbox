Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUIONjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUIONjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUIONhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:37:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52161 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266193AbUIONct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:32:49 -0400
Subject: Re: PCI coprocessors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Bonin <kernel@bonin.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41483BD3.4030405@bonin.ca>
References: <41483BD3.4030405@bonin.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095251402.19893.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 13:30:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 13:55, Andre Bonin wrote:
> 1) Is their support for having two different 'machine types' within one 
> kernel? that is for example, certain executables for intel would get run 
> on an intel processor, and others would get run on processor with type XXXX.

The kernel provides everything you need to run userspace apps on the
co-processor - which is very little indeed. It provides binfmt_misc
which allows other binary types to be revectored to user applications.
That is how the example you remember worked.

Your application gets the program to run, you run it, you throw it at
the coprocessor and you need to take any traps back for syscalls (which
might need a little driver kernel side if it involves interrupts).

There are then the hard bits (mmap, ptrace, scheduling...) 8)

> 2) Is their kernel support for PCI coprocessors for thread allocation 
> etc.  I couldn't find any but i can try looking through the code again.

We don't deal at all with the question of scheduling stuff on different
processor types. 

Alan

