Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUJKUvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUJKUvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 16:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUJKUvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 16:51:50 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:25480 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269242AbUJKUvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 16:51:45 -0400
Message-ID: <58cb370e04101113512d569a6d@mail.gmail.com>
Date: Mon, 11 Oct 2004 22:51:44 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Hacksaw <hacksaw@hacksaw.org>
Subject: Re: udev: what's up with old /dev ?
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200410112006.i9BK62Xn006966@hacksaw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <AE30E0FE-1B7D-11D9-96AD-000D9352858E@linuxmail.org>
	 <200410112006.i9BK62Xn006966@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 16:06:02 -0400, Hacksaw <hacksaw@hacksaw.org> wrote:
> >> If the initrd gets corrupted, are we just hosed?
> >
> >In some way, the answer is yes... I think the best is having a real,
> >on-disk, full "/dev" hierarchy in case the INITRD gets lost or
> >corrupted, which will still allow booting. Now, the INITRD can mount
> >tmpfs over "/dev" and use udev to create needed device nodes.
> 
> And see, this is where I say, what if /dev is hosed too? If the kernel at this
> point gives up, then the user has to dig up a boot CD or something worse and
> start trying to fix the system.

What if kernel image is hosed instead?

Having corrupted initrd is not so diffirent from having corrupted kernel
image and usually they are both located on the same medium...

> If, however, the kernel just made /dev/console and maybe /dev/null, it could
> start a shell and say "/dev missing /console device, initrd corrupted. Hit
> enter for a shell or ctrl-alt-del to reboot."
> 
> As a sys-admin, I'd like that. Get me into single user mode the best you can.
> If a shell can be found, that's good enough.
> --
> The best is the enemy of the good  -- Voltaire
> The Good Enough is the enemy of the Great -- Me
> 
> 
> http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD
