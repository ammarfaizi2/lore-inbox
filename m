Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268523AbUHLQnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268523AbUHLQnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268605AbUHLQnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:43:23 -0400
Received: from mail6.centrum.cz ([213.29.7.198]:23680 "EHLO mail6.centrum.cz")
	by vger.kernel.org with ESMTP id S268523AbUHLQnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:43:21 -0400
Date: Thu, 12 Aug 2004 15:38:45 +0200
From: "Jakub Vana" <gugux@centrum.cz>
To: <alan@lxorguk.ukuu.org.uk>, <gugux@centrum.cz>
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: Centrum Mail 1.0
MIME-Version: 1.0
X-Priority: 3
Subject: Re: x86 - Realmode BIOS and Code calling module
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Message-Id: <20040812133854Z2097966-29039+40063@mail.centrum.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


______________________________________________________________
> Od: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Komu: Jakub Vana <gugux@centrum.cz>
> CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Datum: Thu, 12 Aug 2004 12:56:43 +0100
> Pøedmìt: Re: x86 - Realmode BIOS and Code calling module
>
> On Iau, 2004-08-12 at 10:36, Jakub Vana wrote:
> > Hello,
> > 
> > I have written Linux Kernel module that allows you to call BIOS
> > interupts, Far services or your own code. 
> 
> Why is this better than LRMI in user mode.

I was now looking on LRMI. It must be a nice code, but It is still only V86 emulation. I have listen that some BIOSes use something called Unreal mode, that is realmode with segment registers used like in protected mode. There is only one way, how to set this segregs - switch to prot. mode, but if the BIOS try to switch when is running in V86 CPU generates #GP (Global Protection fault). Not if it is running in real Real Mode.

> To do BIOS calls safely
> you need to be very careful about things like PCI locking, I/O 
> emulation and the ROM scribbling 

I'm not sure abou this, but I think there is not problem in calling BIOS, here is problem in BIOS handling with this features and so It's the problem of programmer that calls the BIOS to safely work and synchronize his hardware in kernel with BIOS. Other hardware (that is not pawn by BIOS) can't make problems.

>in strange places. LRMI can handle this
> in user space as does x86emu in Xorg.
> 
> All you should thus need is an ioctl in vesafb to tell it you've 
> changed the display properties and here is the new layout to use.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


--------------------
Pøipravte se! Je tu ¹kola. Nav¹tivte vèas Palác Flóra. Od 20.srpna do 5.záøí probíhá v Paláci Flóra speciální trh ¹kolních potøeb. http://user.centrum.cz/redir.php?url=http://www.palacflora.com



