Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbRFBFs6>; Sat, 2 Jun 2001 01:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbRFBFst>; Sat, 2 Jun 2001 01:48:49 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:18959 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261645AbRFBFsk>;
	Sat, 2 Jun 2001 01:48:40 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106020548.f525mZV441399@saturn.cs.uml.edu>
Subject: Re: Highmem Bigmem question
To: jlnance@intrex.net
Date: Sat, 2 Jun 2001 01:48:35 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010601112127.A5798@bessie.localdomain> from "jlnance@intrex.net" at Jun 01, 2001 11:21:27 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@intrex.net writes:

> This is probably an FAQ, but I read the FAQ and its not in there.

Odd.

> I have a machine with 2G of memory.  I compiled the kernel with the
> 4G memory option.  How much address space should each process be
> able to address?

3 GB for user stuff, or 3.5 GB with a patch

> Does this change if I use the 64G option?

No. Don't do that.

> I'm after 2.4 information.  Right now I am running on a 2.2 kernel
> and it looks like the user processes are limited to ~1G.

This is not a kernel problem. Try a libc upgrade, or use some
other way to allocate memory. At least sbrk() and mmap() can
be used.
