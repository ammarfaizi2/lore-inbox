Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131454AbRBWGMx>; Fri, 23 Feb 2001 01:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131491AbRBWGMo>; Fri, 23 Feb 2001 01:12:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10768 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131454AbRBWGMY>; Fri, 23 Feb 2001 01:12:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cpu_has_fxsr or cpu_has_xmm?
Date: 22 Feb 2001 22:11:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <974uv8$303$1@cesium.transmeta.com>
In-Reply-To: <200102230538.VAA17793@mail23.bigmailbox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200102230538.VAA17793@mail23.bigmailbox.com>
By author:    "Quim K Holland" <qkholland@my-deja.com>
In newsgroup: linux.dev.kernel
>
> I've been looking at various -ac patches for the last couple of 
> weeks and have been wondering why only this piece of difference
> still remains between Linus' 2.4.2 and Alan's -ac2.  All the other
> diffs in i387.c from 2.4.1-ac2 seem to have been merged into Linus
> tree at around 2.4.2-pre1.  Could anybody explain it for me please?
> 
> --- linux.vanilla/arch/i386/kernel/i387.c       Thu Feb 22 09:05:35 2001
> +++ linux.ac/arch/i386/kernel/i387.c    Sun Feb  4 10:58:36 2001
> @@ -179,7 +179,7 @@
>  
>  unsigned short get_fpu_mxcsr( struct task_struct *tsk )
>  {
> -       if ( cpu_has_fxsr ) {
> +       if ( cpu_has_xmm ) {
>                 return tsk->thread.i387.fxsave.mxcsr;
>         } else {
>                 return 0x1f80;
> 

IMO, XMM is correct here; FXSR is incorrect.  Linus?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
