Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTJAUrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJAUrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:47:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:54713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262360AbTJAUq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:46:59 -0400
Date: Wed, 1 Oct 2003 13:46:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Hockin <thockin@hockin.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
In-Reply-To: <20031001202910.GA30014@hockin.org>
Message-ID: <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Tim Hockin wrote:
> 
> I'd love to put it in uid16.c, but uid16.c is not used by the 64-bit
> architectures.

How about just putting it in "gid16.c" and then adding a CONFIG_GID16
config variable. Then architectures that want it (pretty much all, no?)  
can then obviously just do the

	config GID16
		bool
		default y

in their Kconfig files and be happy. Add the obvious

	obj-$(CONFIG_GID16) += gid16.o

to the kernel makefile and you're done. Looks surgically clean, and 
follows existing practice wrt uid16.

Ok?

		Linus

