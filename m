Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268327AbTAMUVu>; Mon, 13 Jan 2003 15:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268328AbTAMUVu>; Mon, 13 Jan 2003 15:21:50 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42642 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S268327AbTAMUVs>; Mon, 13 Jan 2003 15:21:48 -0500
Date: Mon, 13 Jan 2003 14:30:33 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
In-Reply-To: <15907.5503.334066.50256@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0301131420090.24477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, David Mosberger wrote:

> 
>   Kai> I would suggest an approach like the following, of course
>   Kai> showing only a first simple step. A series of steps like this
>   Kai> should allow for a serious reduction in size of
>   Kai> arch/*/vmlinux.lds.S already, while being obviously correct and
>   Kai> allowing archs to do their own special thing if necessary (in
>   Kai> particular, IA64 seems to differ from all the other archs).
> 
> The only real difference for the ia64 vmlinux.lds.S is that it
> generates correct physical addressess, so that the boot loader doesn't
> have to know anything about the virtual layout of the kernel.
> Something that might be useful for other arches as well...

Hmmh, you mean that the boot loader can just load the vmlinux sections to 
the LMAs, right? Yes, I can see that this makes sense - Most archs don't 
actually load the ELF file, so they don't even have the LMA information,
but for them it shouldn't hurt, either.

So it should be possible to have the correct LMA for all archs w/o
breakage. Might be worth a try.

--Kai


