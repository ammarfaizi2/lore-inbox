Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbTJNNqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTJNNqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:46:40 -0400
Received: from web80702.mail.yahoo.com ([66.163.170.59]:42681 "HELO
	web80702.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262501AbTJNNqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:46:37 -0400
Message-ID: <20031014134636.9110.qmail@web80702.mail.yahoo.com>
Date: Tue, 14 Oct 2003 15:46:36 +0200 (CEST)
From: =?iso-8859-1?q?Hartmut=20Zybell?= <u_zybell@yahoo.de>
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310140821110.19781@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Richard B. Johnson" <root@chaos.analogic.com>
schrieb: > On Tue, 14 Oct 2003, [iso-8859-1] Hartmut
Zybell
> wrote:
> 
> > First things first: Please CC me, because I'm not
> > subscribed.
> >
> > I need a ld-Script to construct an elf-File that
> is a
> > tar-File too. Can
> > anyone help me? Especially the Checksum is tricky.
> >
> [SNIPPED....]
> 
> I don't think you are aware that the kernel is
> compressed,
> then expanded when installed. It therefore has all
> the good
> attributes of a `tar.gz` file without any of the bad
> ones.
> 
Of course I'm aware. But what bad ones do you mean?
> Also, we have a module loader and unloader that
> allows modules
> to be inserted and removed from a running system.
Can you remove modules from a running system, that
are compiled into the kernel? For instance the
Filesystem driver, that were used to boot and is
not longer needed because / has another filesystem
than
/initrd.
> There are
> even experimental systems that allow the whole
> kernel to be
> changed without (apparent) re-booting.
> 
> A file with a 'tar' header is useful for recovering
> a
> directory tree, intact, as it was initially
> backed-up.
> It has no usefulness in the kernel where the content
> of a file (or files) are located into various
> offsets
> in RAM. This is done by the linker and 'helper code'
> within the kernel itself.
I seem to have misread here. I *don't* want to change
the kernel with tar, as you seem to assume. Thats why
I'm asking for an ld-script. I want to be able to
*extract* (READ-ONLY) modules from a kernelfile that
are compiled into this (not currently running) kernel
to insert them into the currently running kernel to
update it. And I want to do it *with* the current
module loader.
> 
> You can readily run an install-system without any
> runtime libraries and/or you can use temporary ones.
> This is currently done for every major distribution.
> 
Of course it's done. You have 2 files: one staticaly
linked to run at install time, one binary archive
(descendent of tar) to install into the system.
If I could make the binary do double duty as install
archive, I could save 50% space. Thats a lot on a
floppy based install. And make no mistake: Even CDROM
(not all, I know!) boot from a floppy image.
> The runtime libraries are not used by the kernel.
> Instead they are used by user-mode code.
> 
I *wrote* that the first example has nothing to do
with
the kernel. It's only there because it's simpler.
And useful too.


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Logos und Klingeltöne fürs Handy bei http://sms.yahoo.de
