Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUKEAXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUKEAXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKEAXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:23:24 -0500
Received: from smtpout.mac.com ([17.250.248.84]:11724 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262499AbUKEAXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:23:18 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCENFPIAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKCENFPIAA.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E2235068-2EC0-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Possible GPL infringement in Broadcom-based routers
Date: Thu, 4 Nov 2004 19:23:14 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2004, at 18:57, David Schwartz wrote:
>
>> Can Broadcom and the vendors "escape" the obligations of the GPL by
>> shipping those proprietary drivers as modules, or are they violating 
>> the
>> GPL plain and simple by removing the related source code (and showing
>> irrelevant code to show "proof of good will") ?
>
> 	That is a contentious issue that has been debated on this group far 
> too
> much. In the United States, at least, the answer comes down to the 
> complex
> legal question of whether the module is a "derived work" of the Linux 
> kernel
> and whether the kernel as shipped with those modules is a "mere
> aggregation".

Well, from what I can see of the makefiles and sources they distribute, 
they
_don't_ distribute it as kernel+modules, they compile their drivers 
directly
into their kernel:

  ./arch/mips/brcm-boards/bcm96345/Makefile:EXTRA_CFLAGS += 
-I$(TOPDIR)/../../targets
  ./drivers/char/bcm96345/board/Makefile:EXTRA_CFLAGS += -I. 
-I$(HPATH)/asm/bcm96345 -I$(TOPDIR)/../../targets -fno-exceptions
  ./Makefile:SUBDIRS              +=modulesrc/drivers ../../targets
  ./Makefile:DRIVERS-y += modulesrc/drivers/kermods.o ../../targets/bp.o

They may call the directory "modulesrc", but it does _NOT_ appear to be
linked as a kernel module, but directly into the kernel.  I think that 
in this
case their build process is too tightly integrated with the kernel to 
_not_
be a derivative work.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


