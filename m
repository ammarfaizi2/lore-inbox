Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSD2Ozz>; Mon, 29 Apr 2002 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSD2Ozx>; Mon, 29 Apr 2002 10:55:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42687 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S312455AbSD2OzM>; Mon, 29 Apr 2002 10:55:12 -0400
Date: Mon, 29 Apr 2002 09:55:11 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "V. Guruprasad" <prasad@watson.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: difficulty with symbol export
In-Reply-To: <20020429083514.A21779@watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0204290951180.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002, V. Guruprasad wrote:

> at the bottom of net/socket.c, and
> 
> 	EXPORT_SYMBOL(get_socket_fileops);
> 
> into net/netsyms.c, expecting to be able to call this function
> from a loadable module and to printk the function addresses
> from the file_operations struct.
> 
> However, on rebooting into this modified kernel, my test module
> fails to load, saying
> 
> 	foo.o: unresolved symbol get_socket_fileops

Basically, you're doing the right thing - what output does

	grep get_socket_fileops /proc/ksyms

show?

Do you have CONFIG_MODVERSIONS turned on in your kernel config? If so,
you probably want to save your .config, make distclean and rebuild from 
scratch - that will likely fix the problem.

--Kai


