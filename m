Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280028AbRKITQJ>; Fri, 9 Nov 2001 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRKITP7>; Fri, 9 Nov 2001 14:15:59 -0500
Received: from zeke.inet.com ([199.171.211.198]:63741 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S280028AbRKITPq>;
	Fri, 9 Nov 2001 14:15:46 -0500
Message-ID: <3BEC2B55.E7873035@inet.com>
Date: Fri, 09 Nov 2001 13:15:33 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: kmalloc(GFP_KERNEL) vs buffer cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

In dealing with a 2.2 kernel, I'm seeing what appears to be a
kmalloc(GFP_KERNEL) failing to allocate memory because the buffer cache
is using most of available RAM.  There are about 5k allocations of about
2k each, done in a loop in an ioctl case (so it is in process context). 
It looks like about 3MB of them succeed before one fails.

Is this hypothesis reasonable or not?  Why?
According to LDD, GFP_KERNEL will try to swap to get memory if
needed--If that is the case, why would it fail to get memory from the
buffer cache?

What is the correct way to allocate a large number of (relatively) small
buffers?  Did this change between 2.2 and 2.4?

TIA,

Eli 
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
