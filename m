Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUJKPgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUJKPgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUJKPc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:32:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269060AbUJKPaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:30:23 -0400
Date: Mon, 11 Oct 2004 08:30:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: suspend-to-RAM [was Re: Totally broken PCI PM calls]
In-Reply-To: <20041011145628.GA2672@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0410110826380.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
 <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
 <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410110739150.3897@ppc970.osdl.org>
 <20041011145628.GA2672@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Pavel Machek wrote:
> 
> Which machine is that, btw? Evo N620c has probably BIOS/firmware bug
> that kills machine on attempt to enter S3 or S4. It takes pressing
> power button 3 times (!) to get machine back.

That's the one. suspend-to-disk works, but suspend-to-ram leaves the fam 
going, and does not come back no matter how many times you press the power 
button. You need to kill it (twice) by holding the power button for five 
seconds (which is the "hard-power-off" signal to the southbridge, when 
everything else is locked up).

suspend-to-disk really shuts off, and comes back after just a single power 
button event. Of course, it's slow and boring, I'd much rather have STR
working ;)

		Linus
