Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbRHLOsd>; Sun, 12 Aug 2001 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269261AbRHLOsX>; Sun, 12 Aug 2001 10:48:23 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:9734 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S269262AbRHLOsH>;
	Sun, 12 Aug 2001 10:48:07 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sun, 12 Aug 2001 15:36:13 +0100."
             <21485.997626973@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 00:48:14 +1000
Message-ID: <3742.997627694@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001 15:36:13 +0100, 
David Woodhouse <dwmw2@infradead.org> wrote:
>
>kaos@ocs.com.au said:
>>  The alternative of having code in some arch directory updating
>> include/asm-$(ARCH)/offsets.h is worse.  It is a terrible design to
>> have code in one makefile updating files in another directory.  It is
>> a layer violation which is always a bad idea.
>
>With sensible (i.e. non-recursive) makefiles, surely this is far more 
>acceptable?

No.  The aim is for a user to look at the makefile in a directory and
know everything that is created in that directory.  If you allow
creation of a file in one directory but storing it in another then you
have to search all makefiles to find out what is created in any
directory.  Horrible!

I was very careful to code the select() and objlink() and related
commands so they can only create files in the current directory, to
enforce a clean design.  You can read a file from another directory but
you cannot write a file to another directory.

