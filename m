Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266597AbUGUSuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUGUSuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266599AbUGUSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:50:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32671 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266597AbUGUSuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:50:37 -0400
To: bruce@it.usyd.edu.au (Bruce Janson)
Cc: rddunlap@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: kexec -l ... --ramdisk=<blah>
References: <200407210653.i6L6rXsd022758@nlp0.cs.usyd.edu.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jul 2004 12:49:39 -0600
In-Reply-To: <200407210653.i6L6rXsd022758@nlp0.cs.usyd.edu.au>
Message-ID: <m1llhd2o1o.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bruce@it.usyd.edu.au (Bruce Janson) writes:

> i Eric, Randy,
>     Thanks for kexec.  It seems to mostly work well, and is an
> improvement on the other contenders (2-kernel monte, bootimg and lobos).

Thanks.  I am bouncing this to lkml since this at the moment does not
appear to be a kexec issue.

I just checked and initial ramdisks work.

The kernel messages I see look like:
> checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
> Freeing initrd memory: 1503k freed


>     I am trying to use kexec's "--ramdisk=..." facility.  Both
> loader and loadee kernels are Linux 2.6.7.  The new kernel loads and
> runs successfully until it tries to mount its root file system.
> Then it fails with this:
> 
>   RAMDISK: Couldn't find valid RAM disk image starting at 0.

That message is because of your root=/dev/ram command line,
and really has nothing to do with your initial ramdisk.
 
>     I believe that the ramdisk image that I supply (to kexec)
> is a well-formed ext2 file system image.  Just for grins I also tried
> a copy of a RedHat 9.0 /boot/initrd* from one of our servers but it
> produced the same failure and message.

Perhaps you did not compile in initrd support?
 
>     The failure message (from .../linux/init/do_mounts_rd.c:130)
> suggests that the booted kernel has not found a valid ext2 superblock
> at the expected ramdisk location.  As I trust the format of the
> ramdisk image I now suspect that the ramdisk location may be wrong.

Unless you have gotten quite creative I doubt it.  Looking at
all of the kernel messages would have been more interesting.

> Any suggestions that you can offer would be appreciated.

See above.

Eric
