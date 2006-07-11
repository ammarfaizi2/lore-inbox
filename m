Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWGKMv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWGKMv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWGKMv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:51:59 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:28654 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751271AbWGKMv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:51:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tvTKx5au84n49XCo2ZjGwaadkxb0EqnG08kSzeTAy0Zcld3wKMcB6g6MC/tUY1oD3XgRN7r4pq0EphSml1zplWOb7mgNy3MEsg9iZ+RT6gvaFBHNA0PgCrv/FQeOb/n+i1HHbEzUU0gIybafRtUWEhjvt6Wq0i8lcD/X270/XmI=
Message-ID: <6bffcb0e0607110551v272deebcua5dc3f782ed25a7f@mail.gmail.com>
Date: Tue, 11 Jul 2006 14:51:57 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Hi Catalin,
> >
> > On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > This is a new version (0.8) of the kernel memory leak detector. See
> > > the Documentation/kmemleak.txt file for a more detailed
> > > description. The patches are downloadable from (the whole patch or the
> > > broken-out series):
> > >
> > > http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc1-kmemleak-0.8.bz2
> > > http://homepage.ntlworld.com/cmarinas/kmemleak/patches-kmemleak-0.8.tar.bz2
> > >
> >
> > Unfortunately, it doesn't compile for me.
> >
> > make O=/dir
> > [..]
> > CC      arch/i386/kernel/alternative.o
> [snip]
>
> When I set DEBUG_KEEP_INIT=n everything works fine.

I was wrong. Here is the new error
/usr/src/linux-work4/kernel/pid.c: In function 'pid_task':
/usr/src/linux-work4/kernel/pid.c:262: error: initializer element is
not constant
/usr/src/linux-work4/kernel/pid.c:262: error: (near initialization for
'__memleak_offset__container_of.offset')
make[2]: *** [kernel/pid.o] Error 1
make[1]: *** [kernel] Error 2
make: *** [_all] Error 2

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
