Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUJPXHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUJPXHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 19:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268959AbUJPXHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 19:07:34 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:57294 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S268955AbUJPXHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 19:07:32 -0400
Subject: Re: [BUG] JVM crashes with 2.6.9-rc2
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041016124519.627456de.akpm@osdl.org>
References: <1097928466.13431.8.camel@localhost>
	 <20041016124519.627456de.akpm@osdl.org>
Date: Sun, 17 Oct 2004 02:07:38 +0300
Message-Id: <1097968058.8033.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At some point in time, I wrote:
> > I also tested 2.6.7, 2.6.8.1, and 2.6.9-rc1 and they all work fine.
> > Reverting Roland's i386 syscall tracing patch [2] from 2.6.9-rc2 makes
> > the problem go away for me.

On Sat, 2004-10-16 at 12:45 -0700, Andrew Morton wrote:
> That's peculiar.  Are you sure about that?

I tested again and I now get the crash with _all_ of the above kernels
so it's definitely not the patch.  Sorry about that.  I'll run memtest86
tomorrow to see if my hardware is broken.

In case anyone is interested, here's the error message:

#
# HotSpot Virtual Machine Error, Internal Error
# Please report this error at
# http://java.sun.com/cgi-bin/bugreport.cgi
#
# Java VM: Java HotSpot(TM) Client VM (1.4.2_06-b03 mixed mode)
#
# Error ID: 43113F32554E54494D45110E4350500308
#
# Problematic Thread: prio=1 tid=0x0805bb08 nid=0x1f48 runnable
#

Heap at VM Abort:
Heap
 def new generation   total 576K, used 576K [0x44750000, 0x447f0000, 0x44c30000)
  eden space 512K, 100% used [0x44750000, 0x447d0000, 0x447d0000)
  from space 64K, 100% used [0x447e0000, 0x447f0000, 0x447f0000)
  to   space 64K,   0% used [0x447d0000, 0x447d0000, 0x447e0000)
 tenured generation   total 4716K, used 3965K [0x44c30000, 0x450cb000, 0x48750000)
   the space 4716K,  84% used [0x44c30000, 0x4500f7c8, 0x4500f800, 0x450cb000)
 compacting perm gen  total 11520K, used 11510K [0x48750000, 0x49290000, 0x4c750000)
   the space 11520K,  99% used [0x48750000, 0x4928daa0, 0x4928dc00, 0x49290000)

		Pekka

