Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313913AbSDJWjI>; Wed, 10 Apr 2002 18:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSDJWjH>; Wed, 10 Apr 2002 18:39:07 -0400
Received: from francis.hilman.org ([216.231.42.188]:40698 "HELO hilman.org")
	by vger.kernel.org with SMTP id <S313913AbSDJWjG>;
	Wed, 10 Apr 2002 18:39:06 -0400
To: linux-kernel@vger.kernel.org
Subject: ioremap() >= 128Mb (was: Memory problem with bttv driver)
From: Kevin Hilman <kevin@hilman.org>
Organization: None to speak of.
Date: Wed, 10 Apr 2002 15:39:05 -0700
Message-ID: <87sn63tbzq.fsf@bugs.hilman.org>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I followed the 'Memory problem with bttv driver' thread from the
archives and was curious if there was any resolution.

The basic problem is that I have a machine with 1G physical memory and
a device with an 128Mb of on-board memory that I would like to
ioremap().  Of course, since VMALLOC_RESERVE is 128Mb this will always
fail if there have been any previous calls to vmalloc() or ioremap()
(which is aways true when the driver loads as a module.)

So far I have a few workarounds, but no good long term solution.
- boot the kernel with less than 1G on cmdline: mem=768M
- hack VMALLOC_RESERVE 

Is it reasonable to make VMALLOC_RESERVE be configurable at boot-time
instead of compile time?

Or, is there a better way to get memory-mapped access to all of the
devices on-board memory?

Thanks.
-- 
Kevin Hilman <kevin@hilman.org>
