Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281987AbRKUVX6>; Wed, 21 Nov 2001 16:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281990AbRKUVXt>; Wed, 21 Nov 2001 16:23:49 -0500
Received: from ns.suse.de ([213.95.15.193]:2579 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281984AbRKUVXd>;
	Wed, 21 Nov 2001 16:23:33 -0500
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Asm style
In-Reply-To: <01112123070300.05447@manta.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Nov 2001 22:23:25 +0100
In-Reply-To: vda's message of "21 Nov 2001 22:13:40 +0100"
Message-ID: <p73wv0jx1gy.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> I'm using GCC 3.0.1 and seeing "multi-line literals are deprecated".
> Since a patch is necessary for that (and someone submitted it already)

The best patch for this IMHO would be to just remove the stupid warning
from gcc. It's obvious that whoever added it has never used gcc inline
assembly.

If they want to remove multi-line strings they need to supply a way to
write inline assembly without strings first. Both solutions below
are very error prone and ugly.

Failing that:

> 	asm(
> 	"	cmd	r,r\n"
> 	"lbl:	cmd	r,r\n"
> 	"	cmd	r,r\n"

Is bearable with some pains.


> #define NL "\n"
> 	asm(
> 	"	cmd	r,r" NL
> 	"lbl:	cmd	r,r" NL

Is also bearable, but needs agreement (needs a central #define) 

-Andi

