Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQKHAze>; Tue, 7 Nov 2000 19:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKHAzY>; Tue, 7 Nov 2000 19:55:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44807 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130180AbQKHAzN>; Tue, 7 Nov 2000 19:55:13 -0500
Message-ID: <3A08A2B4.80E68977@timpanogas.org>
Date: Tue, 07 Nov 2000 17:47:48 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: kernel@kvack.org, Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Installing kernel 2.4
In-Reply-To: <E13tJQl-0007zp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > There are tests for all this in the feature flags for intel and
> > non-intel CPUs like AMD -- including MTRR settings.  All of this could
> > be dynamic.  Here's some code that does this, and it's similiar to
> > NetWare.  It detexts CPU type, feature flags, special instructions,
> > etc.  All of this on x86 could be dynamically detected.
> 
> Detection isnt the issue, its optimisations. Our 386 kernel build is the
> detect all run on any one.
> 
> >     mov      sp, bx
> >     mov      CPU_TYPE, 3  ; 80386 detected
> >     jz       end_get_cpuid
> 
> This is wrong btw. You don;t check for Cyrix with CPUID disabled or
> the NexGen or pre CPUID Cyrix...

Thanks Alan, I'll fix immediately.

Jeff

> 
> > check_CMPXCHG8B:
> >     mov      ax, word ptr ds:FEATURE_FLAGS
> >     and      ax, CMPXCHG8B_FLAG
> >     jz       check_4MB_paging
> 
> This needs a few other bits of interesting checking for non intel chips

I'll grab the code in linux and port.

8)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
