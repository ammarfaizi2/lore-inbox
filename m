Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWJKNjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWJKNjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWJKNjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:39:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3077 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751330AbWJKNjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:39:18 -0400
Date: Wed, 11 Oct 2006 13:16:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: suspend debugging Re: 2.6.18 suspend regression on Intel Macs
Message-ID: <20061011131613.GB4725@ucw.cz>
References: <20061010103910.GD31598@elf.ucw.cz> <1160476889.3000.282.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org> <1160507296.5134.4.camel@funkylaptop> <1160509121.3000.327.camel@laptopd505.fenrus.org> <1160509584.5134.11.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz> <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org> <1160518195.5134.38.camel@funkylaptop> <Pine.LNX.4.64.0610101649440.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610101649440.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm wondering what Pavel does for debugging these things, since the claim 
> was that keeping printk() active would make debugging easier. As it is, it 
> just seems to break suspend exactly because it wants to access devices 
> that are turned off.
> 
> Pavel?

I have framebuffer console here, and just leave printk enabled during
system. Last messages usually tell me where to look for problem...
Plus I test suspend quite often so that regressions show up quickly.

In the early days, plain vga console on machine where bios kicks video
card to work after resume did wonders, and I had to use hardware
debugger on one machine, too.

Another common trick is to test s2disk, first. It tends to catch many
driver problems.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
