Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSEJKX0>; Fri, 10 May 2002 06:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313557AbSEJKXZ>; Fri, 10 May 2002 06:23:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:58383 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313529AbSEJKXY>;
	Fri, 10 May 2002 06:23:24 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.15 hangs at partition check 
In-Reply-To: Your message of "Fri, 10 May 2002 11:21:02 +0200."
             <20020510092102.GA8467@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 May 2002 20:23:10 +1000
Message-ID: <29346.1021026190@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 11:21:02 +0200, 
Tomas Szepe <szepe@pinerecords.com> wrote:
>I don't think ACPI compiles in 2.5.15.
>
>In file included from /usr/src/linux-2.5.15/arch/i386/pci/acpi.c:2:
>.tmp_include/src_000/include/linux/acpi.h:38: ../../drivers/acpi/include/acpi.h: No such file or directory

That is a missing cflags in a kbuild 2.5 Makefile.in.  Add

extra_cflags(acpi.o $(fixme_acpi_includes))

to the end of arch/i386/pci/Makefile.in.

