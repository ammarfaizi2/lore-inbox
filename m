Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTJLVpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTJLVpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:45:15 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:60546 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261190AbTJLVpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:45:12 -0400
Date: Sun, 12 Oct 2003 23:45:04 +0200 (MEST)
Message-Id: <200310122145.h9CLj42k017265@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: sam@ravnborg.org
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003 21:53:55 +0200, Sam Ravnborg wrote:
>On Sun, Oct 12, 2003 at 09:47:48PM +0200, Mikael Pettersson wrote:
>> Notice __start___ex_table[]'s address: it's not 4-byte aligned.
>> With gcc-3.2.3 it got an 8-byte aligned address in my 2.6 kernel.
>> 
>> vmlinux.lds.S doesn't explicitly align __start___ex_table, so I
>> simply put ". = ALIGN(4);" before it and Voila! now it works.
>
>ld will aling the section according to alingment requirements
>of the symbols inside the section.
>So what happens in your case is that . (current address) is
>un-even. But ld alings the section to a 4-byte boundary,
>due to one of the symbols inside the section.
>
>So the better fix is to define the lables inside the section,
>(read: inside the two '{}').
>
>Care to give my patch a check and report back.

Yes, your patch also works.

/Mikael
