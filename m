Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUATVqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUATVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:46:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:37333 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265837AbUATVqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:46:09 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@users.sourceforge.net
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Hugang <hugang@soulinfo.com>, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>
In-Reply-To: <1074623445.2016.10.camel@laptop-linux>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <20040119204551.GB380@elf.ucw.cz>
	 <1074555531.10595.89.camel@gaston>
	 <Pine.GSO.4.58.0401201052320.18625@waterleaf.sonytel.be>
	 <20040120100405.GB183@elf.ucw.cz> <1074598014.739.7.camel@gaston>
	 <20040120113630.GA380@elf.ucw.cz> <1074599060.793.11.camel@gaston>
	 <1074623445.2016.10.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1074634996.739.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 08:43:17 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 05:30, Nigel Cunningham wrote:
> I'm really interested to see how you are going to initiate and execute
> the suspend.
> 
> Perhaps I'm just ignorant, but I can't see how you can do it without
> resorting to the same tricks we use now with regards to CPU context. I
> think you're going to find yourself reinventing the wheel.

CPU context ? I don't think swsusp needs anything different than
suspend-to-RAM in this regard (at least the pmac version of suspend-to
-RAM that wakes up on a CPU reset). The CPU setup will be saved as part
of the kernel data and will be restored after the pages are back in
place the same way it is restored when waking up from RAM. The code
is already there (and actually, that ppc port of swsusp borrowed it).

Ben.


