Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbRGFA0H>; Thu, 5 Jul 2001 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265640AbRGFAZ5>; Thu, 5 Jul 2001 20:25:57 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:56382 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S265646AbRGFAZm>;
	Thu, 5 Jul 2001 20:25:42 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT please; Sybase 12.5 
In-Reply-To: Your message of "Fri, 06 Jul 2001 01:06:53 +1000."
             <3B44828D.C220CAE@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jul 2001 10:25:27 +1000
Message-ID: <4726.994379127@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2001 01:06:53 +1000, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>Ordered data mode is really nice.  It's not magical though - for example,
>if you reset the machine during a kernel build, a subsequent `make' will
>fail because you have a number of .o files which have zero length.

FYI, that particular problem will disappear with the 2.5 Makefiles.
The zero length .o files will still exist but the post-compile
dependency data (.o.d) will not exist so a subsequent make kernel will
rebuild the incomplete objects.  This is a general workaround for
incomplete kernel objects, independent of the file system type.

