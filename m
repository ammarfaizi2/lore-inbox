Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbSJ1Dia>; Sun, 27 Oct 2002 22:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSJ1Dia>; Sun, 27 Oct 2002 22:38:30 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:21941 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262823AbSJ1Di3> convert rfc822-to-8bit; Sun, 27 Oct 2002 22:38:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Andrew Pimlott <andrew@pimlott.net>, Andi Kleen <ak@suse.de>
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Date: Sun, 27 Oct 2002 12:57:46 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net>
In-Reply-To: <20021027152038.GA26297@pimlott.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210271157.46153.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 09:20, Andrew Pimlott wrote:

> Example problem case (assuming a fs that stores only seconds, and a
> make that uses nanoseconds):
>
> - I run the "save and build" command while editing foo.c at T = 0.1.
> - foo.o is built at T = 0.2.
> - I do some read-only operations on foo.c (eg, checkin), such that
>   foo.o gets flushed but foo.c stays in memory.
> - I build again.  foo.o is reloaded and has timestamp T = 0, and so
>   gets spuriously rebuilt.

If your system, and your disks, are so fast that they can not only finish the 
build in under a second but can also flush the cache and reload it from disk 
in under a second, then:

A) the spurious rebuild is still a tiny fraction of a second.
B) You're seeing a penalty for using a filesystem that's too old for your 
setup.  This is a configuration problem in userspace.
C) How would having ALL times rounded to a second be an improvement?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
