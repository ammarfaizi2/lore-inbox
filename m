Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUFGVeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUFGVeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUFGVdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:33:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5760 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265079AbUFGVbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:31:50 -0400
Date: Mon, 7 Jun 2004 17:31:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to configure/build a kernel in a separate directory?
In-Reply-To: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0406071710540.1435@chaos>
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, Robert P. J. Day wrote:

>
>   (i originally posted this to the "make" mailing list, but i figured
> someone here *must* have done this before.)
>
>   is there an easy way to configure/build one or both of a 2.4 and 2.6
> kernel in a totally separate directory from the source directory itself?
>
>   i'd like to have a totally pristine ("make mrproper"ed) source tree,
> write-protected, readable by all, so that several developers can
> independently configure and build their own kernels without stepping on
> each other.  currently, they all check out their own copy of the source
> via CVS, which starts to take up a lot of space.
>
>   obviously, it would be great if they could all set up some kind of build
> structure where they could do their own configuration and build in their
> personal work directories, so that *all* generated results (header files,
> object files, etc.) are placed in their work directory -- nothing should
> be generated in the kernel source tree itself.
>
>   i'm suspecting that, if there are solutions, they will be different from
> 2.4 to 2.6, so i'll take whatever solutions i can get.  others have
> suggested using gnu make in combination with "VPATH", but i'm not sure
> that's going to work, as VPATH deals strictly with pre-requisites in other
> directories, not executable programs like scripts.
>
> rday


I would make a script that creates a symbolic-link of all the
source-files and headers. To get it right, put the source on
a r/o file-system as a start. It's a lot of work.

`find . -name "*.[chS]"` should get all the sources, but there
are some scripts you will have to hunt for.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


