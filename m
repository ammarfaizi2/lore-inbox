Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264685AbSJOQRZ>; Tue, 15 Oct 2002 12:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSJOQRZ>; Tue, 15 Oct 2002 12:17:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:49810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264685AbSJOQRY>;
	Tue, 15 Oct 2002 12:17:24 -0400
Subject: Re: [PATCH] 2.5.41: lkcd (8/8): dump driver and build files
From: Mark Haverkamp <markh@osdl.org>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210101345430.29122-101000@nakedeye.aparity.com>
References: <Pine.LNX.4.44.0210101345430.29122-101000@nakedeye.aparity.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Oct 2002 09:24:17 -0700
Message-Id: <1034699059.23807.4.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 13:48, Matt D. Robinson wrote:
> This is the complete set of dump drivers for creating crash dumps
> during panic/exception situations in the Linux kernel.  It can be
> built as a module or as a built-in with the kernel.
> 
>  drivers/Makefile             |    1
>  drivers/dump/Makefile        |   30
>  drivers/dump/dump_base.c     | 1867 +++++++++++++++++++++++++++++++++++++++++++ drivers/dump/dump_blockdev.c |  411 +++++++++
>  drivers/dump/dump_gzip.c     |  129 ++
>  drivers/dump/dump_i386.c     |  315 +++++++
>  drivers/dump/dump_rle.c      |  176 ++++
>  include/asm-i386/dump.h      |   94 ++
>  include/linux/dump.h         |  440 ++++++++++
>  9 files changed, 3463 insertions(+)
> 
> This is included as a gzip'd attachment, as the size is too
> big for vger, apparently.
> 
> --Matt


Shouldn't the module exit functions in dump_base.c be marked with __exit
rather than __init?

