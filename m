Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTHUACo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 20:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTHUACo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 20:02:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58065 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262279AbTHUACm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 20:02:42 -0400
Message-ID: <3F440C15.1050301@pobox.com>
Date: Wed, 20 Aug 2003 20:02:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Rob Landley <rob@landley.net>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <lRjc.6o4.3@gated-at.bofh.it> <3F4120DD.3030108@softhome.net> <20030818190421.GN24693@gtf.org> <200308190832.24744.rob@landley.net> <20030820234810.GA24970@mail.jlokier.co.uk>
In-Reply-To: <20030820234810.GA24970@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Well, I've done quite a bit of
> 
> 	#ifdef __i386__
> 	#define __NR_futex	240
> 	#elif defined (__alpha__)
> 	#define __NR_futex	394
> 	#elif defined (__mips__)
> 	... etc. ...
> 	#endif
> 
> In order to distribute programs which compile with a distro's libc but
> will take advantage of features in later kernels when run on them.
> 
> That's really unpleasant.  So, in revenge, here's an annoying question:

agreed.


> If userspace applications are ultimately compiled using Linux header
> files, indirectly included via Glibc or some other libc, and the
> kernel header files are GPL (version 2 only; not LGPL or any later
> GPL), isn't distributing those binary applications a gross violation
> of the GPL in some cases?

It's come up before, so it's not necessarily an original, annoying 
question ;-)

My non-lawyer guess would be, the structures and defines are required 
for Linux interoperability; that may be a factor.  static inline 
functions in headers, i.e. real code, is another matter too.

One way or another (direct inclusion, or via glibc-kernheaders pkg) the 
headers today are GPL'd not LGPL'd... so I suppose it remains the realm 
of lawyers...

IANAL,

	Jeff



