Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJNMbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbTJNMbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:31:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42629 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262410AbTJNMbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:31:37 -0400
Date: Tue, 14 Oct 2003 08:32:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Hartmut=20Zybell?= <u_zybell@yahoo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
In-Reply-To: <20031014114135.68297.qmail@web80702.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0310140821110.19781@chaos>
References: <20031014114135.68297.qmail@web80702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, [iso-8859-1] Hartmut Zybell wrote:

> First things first: Please CC me, because I'm not
> subscribed.
>
> I need a ld-Script to construct an elf-File that is a
> tar-File too. Can
> anyone help me? Especially the Checksum is tricky.
>
[SNIPPED....]

I don't think you are aware that the kernel is compressed,
then expanded when installed. It therefore has all the good
attributes of a `tar.gz` file without any of the bad ones.

Also, we have a module loader and unloader that allows modules
to be inserted and removed from a running system. There are
even experimental systems that allow the whole kernel to be
changed without (apparent) re-booting.

A file with a 'tar' header is useful for recovering a
directory tree, intact, as it was initially backed-up.
It has no usefulness in the kernel where the content
of a file (or files) are located into various offsets
in RAM. This is done by the linker and 'helper code'
within the kernel itself.

You can readily run an install-system without any
runtime libraries and/or you can use temporary ones.
This is currently done for every major distribution.

The runtime libraries are not used by the kernel.
Instead they are used by user-mode code.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


