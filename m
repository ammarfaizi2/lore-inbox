Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316174AbSEKAAb>; Fri, 10 May 2002 20:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316176AbSEKAAa>; Fri, 10 May 2002 20:00:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:62738 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316174AbSEKAA2>;
	Fri, 10 May 2002 20:00:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: Your message of "Fri, 10 May 2002 15:58:16 MST."
             <3CDC5088.C723E5AA@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 10:00:13 +1000
Message-ID: <2045.1021075213@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002 15:58:16 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>Well given that kbuild-2.5 has a single makefile running
>out of $(TOPDIR), it _should_ be chopping the absolute
>pathname out of the include path and the .c path:
>
>	gcc -I include drivers/net/foo.c
>
>There will be no starting-with-slash __FILE__s in the output of
>this command.

Separate source and object.  Multiple source trees to support
additional drivers, filesystems etc.  kbuild 2.5 runs in the object
directory, reading from the source directories.  Path names are
absolute.

