Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbSIQCHX>; Mon, 16 Sep 2002 22:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263495AbSIQCHW>; Mon, 16 Sep 2002 22:07:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:20469 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263476AbSIQCHV>; Mon, 16 Sep 2002 22:07:21 -0400
Date: Mon, 16 Sep 2002 22:12:19 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: linux-aio@kvack.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libaio 0.3.92 test release
Message-ID: <20020916221219.A22465@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I've just uploaded the libaio 0.3.92 test release to kernel.org.  Most 
notably, this release passes a few basic tests on ia64, and should work 
on x86-64 too (but isn't tested).  An updated kernel patch can be found
in /pub/linux/kernel/people/bcrl/aio/patches/testing/aio-20020916.diff 
which uses the registered syscall ABI (no more dynamic syscalls), fixes 
a bug in io_submit that allowed iocbs to be read from kernel memory 
(that bug is not present in RH 2.1AS; the fix was lost in the 2.4.18 
merge), fixes an occasional hang caused by timers not being unregistered 
in io_getevents, and probably introduces a few other bugs.  This is a 
test release as I still have to split up the patches into -stable, 
-alpha and -developement to prevent people from shipping experimental 
code that was never meant to be used on production machines.  In any 
case, if people could give this a whirl and submit reports to 
linux-aio@kvack.org, it would be appreciated.  My hit list still 
includes getting ARM, PPC, S/390, SPARC and m68k support merged into 
libaio, so if anyone cares to provide patches, I'd appreciate it.  Cheers,

		-ben
