Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbQKLAT4>; Sat, 11 Nov 2000 19:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKLATZ>; Sat, 11 Nov 2000 19:19:25 -0500
Received: from slc644.modem.xmission.com ([166.70.7.136]:36871 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129121AbQKLASv>; Sat, 11 Nov 2000 19:18:51 -0500
To: Adam Lazur <alazur@progeny.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 17:00:28 -0700
In-Reply-To: Adam Lazur's message of "Sat, 11 Nov 2000 17:11:58 -0500"
Message-ID: <m1bsvmcb4z.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Lazur <alazur@progeny.com> writes:

> Eric W. Biederman (ebiederm@xmission.com) said:
> > I have recently developed a patch that allows linux to directly boot
> > into another linux kernel.  With the code freeze it appears
> > inappropriate to submit it at this time. 
> 
> Aside from what looks to be support for SMP, how does this differ from
> the two kernel monte stuff at http://scyld.com/software/monte.html ?

I admit that LOBOS, two kernel monte, and the one by by Werner Almsberg.
Were all related work that I looked at.  And I acknowledge
there were some good ideas I pilfered from all of them.

There are a couple of differences.  
But the big one is I'm trying to do it right.  In particular
this means fixing the problem where the problem is.

Additionally I'm killing backwards compatibility with a lot of short
sited things.

And multiplatform support is in the plan.  So long term this should
run on alpha, and x86, and sparc and everything else out there
that linux supports.  This means that you can have a multiplatform
boot loader.  There will have to be glue code out there to get
started from different firmware on different machines but that is it.

Additionally mine is the only one that has a real chance of booting
a non-linux kernel.  Gathering the non probable hardware information
is hard.  Currently mine implementation is the only one to not simply
copy the boot parameters page that is give to the linux kernel.

Unlike 2 kernel monte mine deliberately has no reliance upon a BIOS.

There is another major difference as well.  kexec is part of work
on the linuxBIOS project.  Where the goal is to have a very minimal
firmware before booting into linux.  And to use that initial linux
kernel as the firmware hardware drivers.  What this means is kexec
is being developed from a point of view that needs it.  If you don't
have a BIOS kexec is a must.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
