Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbSLTD4Z>; Thu, 19 Dec 2002 22:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267719AbSLTD4Z>; Thu, 19 Dec 2002 22:56:25 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:43471 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267717AbSLTD4Y>;
	Thu, 19 Dec 2002 22:56:24 -0500
Date: Fri, 20 Dec 2002 15:03:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@ucw.cz, torvalds@transmeta.com, hpa@transmeta.com,
       drepper@redhat.com, jun.nakajima@intel.com, matti.aarnio@zmailer.org,
       hugh@veritas.com, davej@codemonkey.org.uk, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-Id: <20021220150324.37c1c3dd.sfr@canb.auug.org.au>
In-Reply-To: <1040353515.30925.16.camel@irongate.swansea.linux.org.uk>
References: <3DFFED33.2020201@transmeta.com>
	<Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
	<20021218234512.GA705@elf.ucw.cz>
	<1040353515.30925.16.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 2002 03:05:15 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Wed, 2002-12-18 at 23:45, Pavel Machek wrote:
> > IIRC, segment 0x40 was special in BIOS days, and some APM bioses
> > blindly access 0x40 even from protected mode (windows have segment
> > 0x40 with base 0x400....) Is that issue you are hitting?
> 
> Well the spec says it is not special. Windows leaves it pointing to
> 0x400 and if you don't do that your APM doesn't work.

The problem with the new syscall stuff is fixed in BK (the GDT was no longer
long enough ...)

The 0x40 thing is set up and torn down for each BIOS call these days.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
