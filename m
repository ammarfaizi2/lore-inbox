Return-Path: <linux-kernel-owner+w=401wt.eu-S965129AbXAJVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbXAJVeM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 16:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbXAJVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 16:34:12 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54962 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965125AbXAJVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 16:34:09 -0500
Date: Wed, 10 Jan 2007 13:33:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Jean Delvare <khali@linux-fr.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: .version keeps being updated
In-Reply-To: <20070110193136.GA30486@aepfle.de>
Message-ID: <Pine.LNX.4.64.0701101331440.3594@woody.osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <20070110193136.GA30486@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2007, Olaf Hering wrote:
>
> On Wed, Jan 10, Linus Torvalds wrote:
> 
> > Grr.
> 
> It did work for me for some reason, but I was wondering why it did work.

Because you didn't have CIFS compiled in? Right now that's the only other 
module that would trigger that particular string in memory, I think. So 
purely by luck.

> Cant we just invent a .data.uts section and put that into the
> i386/x86_64/ia64/s390/powerpc vmlinux.lds.S files?
> '"Linux version " UTS_RELEASE' in version.c

I'd rather have the problem fixed by just not doing the binary scrounging 
at all, or at the very least making the pattern-matching so strict that 
there's no way other "Linux version " strings can trigger..

		Linus
