Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJ2Ofr>; Tue, 29 Oct 2002 09:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJ2Ofr>; Tue, 29 Oct 2002 09:35:47 -0500
Received: from rakshak.ishoni.co.in ([164.164.83.140]:425 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S261729AbSJ2Ofr>; Tue, 29 Oct 2002 09:35:47 -0500
Subject: mlockall() with MCL_FUTURE
From: Amol Kumar Lad <amolk@ishoni.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 29 Oct 2002 20:11:46 -0500
Message-Id: <1035940307.2256.25.camel@amol.in.ishoni.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I was just going through its implementation. If mlockall() is invoked
with MCL_FUTURE, does it mean that all the existing locked mappings of
process should get unlocked ? Attaching code segment from do_mlockall().
I am using 2.4.18 kernel

static int do_mlockall(int flags)
{
   ...
                newflags = vma->vm_flags | VM_LOCKED;
                if (!(flags & MCL_CURRENT))
                        newflags &= ~VM_LOCKED;
                error = mlock_fixup(vma, vma->vm_start, vma->vm_end,
newflags);
   ...
}

please cc me.

thanks
Amol



