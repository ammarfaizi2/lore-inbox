Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132324AbQKKUKG>; Sat, 11 Nov 2000 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbQKKUJ5>; Sat, 11 Nov 2000 15:09:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37384 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132368AbQKKUJp>; Sat, 11 Nov 2000 15:09:45 -0500
Message-ID: <3A0DA785.C69F1EA1@transmeta.com>
Date: Sat, 11 Nov 2000 12:09:41 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: Max Inux <maxinux@bigfoot.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111133050.1029-100000@saturn.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Fri, 10 Nov 2000, H. Peter Anvin wrote:
> > >
> > > On x86 machines there is a size limitation on booting.  Though I thought
> > > it was 1024K as the max, 900K should be fine.
> > >
> >
> > No, there isn't.  There used to be, but it has been fixed.
> >
> 
> Are you sure? I thought the fix was to build 2 page tables for 0-8M
> instead of 1 page table for 0-4M. So, we still cannot boot a bzImage more
> than 2.5M which roughly corresponds to 8M. Is this incorrect? Are you
> saying I should be able to boot a bzImage corresponding to an ELF object
> vmlinux of 4G or more?
> 
> I tried it and it failed (a few weeks ago) so at least reasonably recently
> what you are saying was not true. I will now check if it suddenly became
> true now.
> 

That wasn't the fix in question (there was a 1 MB *compressed* limit for
a while), but you're right, for now the limit is 8 MB *uncompressed.*

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
