Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278258AbRJMDMa>; Fri, 12 Oct 2001 23:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278257AbRJMDMK>; Fri, 12 Oct 2001 23:12:10 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:10001 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278256AbRJMDMD>;
	Fri, 12 Oct 2001 23:12:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: Your message of "Fri, 12 Oct 2001 21:56:42 EST."
             <Pine.LNX.3.96.1011012215110.20962C-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Oct 2001 13:12:17 +1000
Message-ID: <15369.1002942737@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001 21:56:42 -0500 (CDT), 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>The easy solution to all this is obviously to build crc32 into the
>kernel unconditionally, and live with the kernel bloat.  I don't like
>kernel bloat, so I prefer the non-easy option.

Not when your non-easy option requires every driver that needs a
library routine to patch lib/Makefile.  Adding a new driver should not
require a patch to an unrelated area of the kernel, it is bad design.
It also results on overlapping patches with the attendent risk of patch
rejects.  Anybody remember the common Space.c and all the problems that
file caused?

Kernel bloat is bad.  A kbuild design that will cause maintainence
problems in future is even worse.  Setting CONFIG_CRC32 at the time the
driver is selected is the cleanest solution.

