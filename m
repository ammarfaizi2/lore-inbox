Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSDXAkK>; Tue, 23 Apr 2002 20:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSDXAkJ>; Tue, 23 Apr 2002 20:40:09 -0400
Received: from zok.SGI.COM ([204.94.215.101]:53176 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S314500AbSDXAkI>;
	Tue, 23 Apr 2002 20:40:08 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available 
In-Reply-To: Your message of "Tue, 23 Apr 2002 11:23:31 +0200."
             <20020423112331.B1142@riesen-pc.gr05.synopsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Apr 2002 08:29:43 +1000
Message-ID: <16499.1019600983@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002 11:23:31 +0200, 
Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>Small issue with generation of defkeymap.c:
>i got error that there was no permission to write in the file from
>/bin/sh. Sorry, accidentially typed Ctrl-L in terminal and the error was
>lost. I'll try to reproduce it (it's not every time).

Standard problem when the kernel ships files that are also overwritten
at run time.  You get permission problems if the kernel code is marked
read only.  After kbuild 2.5 goes in I have a list of FIXME files to
clean up.

>Btw, why it isn't possible to run "make clean installable"?
>Or at least "make clean oldconfig installable"?

Race conditions when running parallel make.  With kbuild 2.5 you do not
need to make clean before building, unlike the existing build system,
kbuild 2.5 gets it right.

