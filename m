Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUATLZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 06:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265363AbUATLZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 06:25:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:35028 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265354AbUATLZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 06:25:23 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pavel Machek <pavel@ucw.cz>, ncunningham@users.sourceforge.net,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
In-Reply-To: <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston>
	 <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1074597734.737.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 22:22:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Swsusp saves the data structures from the suspended kernel, so they have to
> match the data structures of the resumed kernel, right?
> 
> I't s a bit like trying insmod -f on a module compiled for a completely
> different kernel version... *bang*

No, swsusp saves the whole memory image, including the old kernel. The
"boot" kernel is only used as a loader until all pages are put back in
place and control can be given back to the old kernel. Well, that might
not exactly be what x86 does but that's definitely waht I'll do on PPC :)

Ben.


