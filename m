Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRC2VLc>; Thu, 29 Mar 2001 16:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbRC2VLM>; Thu, 29 Mar 2001 16:11:12 -0500
Received: from [128.121.155.109] ([128.121.155.109]:63250 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S129051AbRC2VLF>; Thu, 29 Mar 2001 16:11:05 -0500
From: dank@trellisinc.com
To: linux-kernel@vger.kernel.org
Cc: Eli Carter <eli.carter@inet.com>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
X-Newsgroups: mlist.linux-kernel
In-Reply-To: <3ABA15F7.6155F0EE@inet.com>
User-Agent: tin/1.4.2-20000205 ("Possession") (UNIX) (Linux/2.2.14-6.1.1 (i586))
Message-Id: <20010329210925.3161C6E099@fancypants.trellisinc.com>
Date: Thu, 29 Mar 2001 16:09:25 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter wrote:
> Hmm... I used __inline__ because the other function in the same
> headerfile used it...  What is the difference between the two, and is
> one depricated now?  (And what about in 2.2.x?)

the inline keyword was not added into the c language until the ansi/iso
c99 revision, echoing its use in c++.  prior to that time, gcc supplied
__inline__ as a vendor extension simulating this behavior which could be
compiled without violating checks for strict ansi conformance. 

with the new ansi standard, this use of __inline__ is no longer
necessary, although for gcc to grok it as legal ansi requires (iirc) the
macro _ISOC99_SOURCE_ must be defined.

-- 
nick black * head developer, trellis network security * www.trellisinc.com
"the tao gave birth to machine language.  machine language gave birth to the
 assembler.  the assembler gave rise to the compiler.  now there are ten
 thousand languages.  each has its place, but avoid cobol if you can." - ttop
