Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSFGDDq>; Thu, 6 Jun 2002 23:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSFGDDp>; Thu, 6 Jun 2002 23:03:45 -0400
Received: from rj.SGI.COM ([192.82.208.96]:32226 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S316601AbSFGDDo>;
	Thu, 6 Jun 2002 23:03:44 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild-2.5 on 2.4.19-pre10-ac2 build error when modular support turned off 
In-Reply-To: Your message of "Thu, 06 Jun 2002 18:48:53 MST."
             <000d01c20dc5$7a5b08e0$66aca8c0@kpfhome> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Jun 2002 13:03:37 +1000
Message-ID: <11283.1023419017@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 18:48:53 -0700, 
"Kevin P. Fleming" <kpfleming@cox.net> wrote:
>I had a kernel built and working fine with module support turned on, only a
>single driver (ide-floppy) compiled as a module. I then did "make -f
>Makefile-2.5 menuconfig" and turned off loadable module support, kmod and
>double-checked that ide-floppy changed to built-in (it did).
>
>I then did "make -f Makefile-2.5 -j2 installable", and kbuild rebuilt very
>little, and the final link died with failed references to "request_module".
>It appears that kbuild did not rebuild the entire kernel, even though would
>have been necessary.

It is a bug in standardizing dependency names when using common source
and object trees, I will correct it and roll core-18 this afternoon.
Separate source and object work fine for this case.

