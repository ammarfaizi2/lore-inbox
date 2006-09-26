Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWIZIsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWIZIsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWIZIsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:48:14 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:34396 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S1750729AbWIZIsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:48:13 -0400
Subject: Re: 2.6.18-mm1 compile failure on x86_64
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4518E4DF.8010007@goop.org>
References: <45185A93.7020105@google.com> <4518DC0B.10207@shadowen.org>
	 <4518E4DF.8010007@goop.org>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:48:24 +0100
Message-Id: <1159260504.28313.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2006 08:48:11.0339 (UTC) FILETIME=[7F20D1B0:01C6E148]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 01:29 -0700, Jeremy Fitzhardinge wrote:
> Andy Whitcroft wrote:
> > Martin Bligh wrote:
> >   
> >> http://test.kernel.org/abat/49037/debug/test.log.0   
> >>
> >>   AS      arch/x86_64/boot/bootsect.o
> >>   LD      arch/x86_64/boot/bootsect
> >>   AS      arch/x86_64/boot/setup.o
> >>   LD      arch/x86_64/boot/setup
> >>   AS      arch/x86_64/boot/compressed/head.o
> >>   CC      arch/x86_64/boot/compressed/misc.o
> >>   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> >> BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file
> >> offset 0x804700c0.
> >> /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy:
> >> arch/x86_64/boot/compressed/vmlinux.bin: File truncated
> >> make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
> >> make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
> >> make: *** [bzImage] Error 2
> >> 09/25/06-09:13:48 Build the kernel. Failed rc = 2
> >> 09/25/06-09:13:49 build: kernel build Failed rc = 1
> >>
> >> Wierd. Same box compiled 2.6.18 fine.
> >>     
> >
> > Pretty sure this isn't a space problem, as we have just checked space
> > before the build and I've taken no action since then.  Someone did
> > mention "tool chain issue" when it was first spotted.  Will check with
> > them and see why they thought that.
> >   
> 
> Does this box have an older version of binutils (2.15?)?  If so, it 
> might be getting upset over the patch "note-section" in Andi's queue.  I 
> know it has been a bit problematic, but I don't know if the problems 
> manifest in this way.

I've not seen it manifest like this but it would be worth trying Jan's
patch from
http://lists.xensource.com/archives/html/xen-devel/2006-08/msg01416.html
to see if it helps.

Andi removed an identical patch (from someone else) from his queue due
to http://marc.theaimsgroup.com/?l=linux-kernel&m=115629369729911&w=2 We
have had the patch in the Xen tree for a couple of weeks now with no
reported problems.

Ian.



