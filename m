Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTHTXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbTHTXs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:48:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:36738 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262268AbTHTXs2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:48:28 -0400
Date: Thu, 21 Aug 2003 00:48:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030820234810.GA24970@mail.jlokier.co.uk>
References: <lRjc.6o4.3@gated-at.bofh.it> <3F4120DD.3030108@softhome.net> <20030818190421.GN24693@gtf.org> <200308190832.24744.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308190832.24744.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I've done quite a bit of

	#ifdef __i386__
	#define __NR_futex	240
	#elif defined (__alpha__)
	#define __NR_futex	394
	#elif defined (__mips__)
	... etc. ...
	#endif

In order to distribute programs which compile with a distro's libc but
will take advantage of features in later kernels when run on them.

That's really unpleasant.  So, in revenge, here's an annoying question:

If userspace applications are ultimately compiled using Linux header
files, indirectly included via Glibc or some other libc, and the
kernel header files are GPL (version 2 only; not LGPL or any later
GPL), isn't distributing those binary applications a gross violation
of the GPL in some cases?

-- Jamie
