Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSDQRpW>; Wed, 17 Apr 2002 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDQRpV>; Wed, 17 Apr 2002 13:45:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34382 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S293131AbSDQRpU>; Wed, 17 Apr 2002 13:45:20 -0400
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 boot enhancements, boot bean counting 8/11
In-Reply-To: <m1elhegt1c.fsf@frodo.biederman.org>
	<3CBDA073.6010700@evision-ventures.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 11:37:53 -0600
Message-ID: <m1sn5ufcpa.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com> writes:

> Eric W. Biederman wrote:
> > Linus please apply,
> > Rework the actual build/link step for kernel images.  - remove the need for
> > objcopy
> > - Kill the ROOT_DEV Makefile variable, the implementation
> >   was only half correct and there are much better ways
> >   to specify your root device than modifying the kernel Makefile.
> > - Don't loose information when the executable is built
> 
> Coudl you please use sufficiently large fields for kdev_t variables?
> This way if we once have bigger device id spaces one will not have
> to mess with the boot code again.
> Thank you.

1) This patch doesn't change anything except to document which fields
   are present, and how big they are, and no there isn't enough room
   to trivially expand these fields.
2) Exporting kdev_t from the kernel would be very bad.
3) swapdev is long dead, and root_dev while it works is unnecessary,
   you can specify it on the command line just fine.

So we already are future proofed, and the change you suggest would be
a bad one.  The compiled in command line fully supports the ability
to set your root device, so no functionality is lost.

Like I said in my intro a lot of this code simply makes what the boot
processes is currently doing more visible.

Eric
