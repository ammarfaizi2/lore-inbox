Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTEFWFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEFWFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:05:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10624 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261335AbTEFWFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:05:53 -0400
Date: Tue, 6 May 2003 23:18:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506221819.GC6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <20030506204305.GA5546@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506204305.GA5546@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> If you can make those drivers in your userspace, its certainly okay...

Agreed.  Now, what is userspace?

If I load a Java class into a Java VM, that class is executing in the
VM's "userspace", even though both the class and VM execute together
in the underlying kernel's userspace.  If I load an Emacs Lisp library
into Emacs, that's ok too in the same way.

I don't want to go over this old argument of where the interface
boundaries are.  That's a very old argument and thoroughly off topic
for this list.

What I want to know is the reasonableness of using Linux drivers,
filesystems and network stack, extracted from the Linux kernel, in
something that is not Linux and not necessarily GPL'd, using a very
clear _virtual_ boundary between the Linux parts and the not GPL'd part.

Running User Mode Linux on HP-UX would be an example which I think is
clearly acceptable.  (Note that User Mode Linux doesn't access devices
directly, but perhaps it could with some changes).

I have in mind a virtual machine which is capable of executing device
drivers written in an appropriate subset of the C language, in which
wrappers for Linux (and BSD) drivers can be written, so the Java and
Emacs VM examples above are quite appropriate.

This seems reasonable to me, although it also seems like quite a
perversion of Linux to fragment it into GPL'd parts atop a non-GPL'd
kernel, which is why I had to (being a pervert :) mention the idea on
this list.

-- Jamie
