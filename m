Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTFDP2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFDP2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:28:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47621 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263452AbTFDP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:28:52 -0400
Date: Wed, 4 Jun 2003 08:41:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       Stewart Smith <stewartsmith@mac.com>, <linux-kernel@vger.kernel.org>,
       Stewart Smith <stewart@linux.org.au>
Subject: Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols
In-Reply-To: <20030604153224.GF19929@gtf.org>
Message-ID: <Pine.LNX.4.44.0306040838370.13753-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jun 2003, Jeff Garzik wrote:
> 
> Any opinions on moving it out of lib/lib.a?
> 
> We have our own conditional linking system, essentially, so that's what
> I would prefer.

That makes sense. lib/lib.a wasn't ever _that_ sensible, since we only 
really include object files in it that we know should be linked in. The 
linker really does know less than the build system, and in this case that 
seems to be causing a real bug.

		Linus

