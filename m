Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUDZP44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUDZP44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUDZP44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:56:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262923AbUDZP40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:56:26 -0400
Date: Mon, 26 Apr 2004 11:56:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Lucas=20Silva?= <mrprofetas@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: BIOS vs Kernel
In-Reply-To: <20040426150524.63980.qmail@web86406.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.53.0404261145210.1494@chaos>
References: <20040426150524.63980.qmail@web86406.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2004, [iso-8859-1] Lucas Silva wrote:

> Before I start working on this I would like to find
> out
> if it is possible or at least useful.
>
> Is it feasible?
> To create a BIOS that would help the kernel  (working
> together).
>
> What if the BIOS booted the PC in protected mode ,
>  enabling the A20 (taking away all that backwards
> support, so on),
>  And then implement a realible interface.
>
> Wouldn't that be faster?
> Would the kernel be able to communicate to it?
>
> Thanks Profetas

The reason why the BIOS boots in 'real' mode is because there
are 'real' mode drivers provided by vendors that are added during
the POST routine. For instance a SCSI boot disk, or a LAN card
used to boot. If I were not for this, you could just boot in
protected-mode.

However, the BIOS does much, much, more than boot the machine!
Modern motherboards are very dumb as soon as the power is
applied. They are literly built by the BIOS. The final construction
(like how pins of electronic blobs are connected and the internal
guts of gate-arrays) is all done by the BIOS. It's not just a
matter of turning on chips like the old IBM manuals show.

So you need the BIOS to build the board. It starts the boot-sequence
in 'real' mode so that's what you have. FYI, the BIOS code has
already transitioned to and from 32-bit linear address space,
probably several times, during the POST routine. It's really
quite trivial. Whether or not the boot-code gets to 32-bit mode
right away or later on in the boot sequence is simply dependent
upon being able to complete the loading of the operating system
from the IPL device.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


