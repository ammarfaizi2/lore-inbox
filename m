Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUJLTuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUJLTuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJLTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:50:55 -0400
Received: from gprs212-24.eurotel.cz ([160.218.212.24]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267649AbUJLTux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:50:53 -0400
Date: Tue, 12 Oct 2004 21:50:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: ncunningham@linuxmail.org, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041012195039.GA1070@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <200410111437.17898.david-b@pacbell.net> <20041012085349.GA2292@elf.ucw.cz> <200410121152.53140.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410121152.53140.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you are entering S4 or S5 at the end of swsusp basically should not
> > matter to anyone. What we tell the drivers is same in both cases.
> 
> The problem cases are on resume, where drivers
> can see different controller state.  Both S4 and S5
> resume can leave it in reset; fine.  But from S4
> the other option is the controller being in the state
> set up previously by the driver ... yet from S5 the
> other option is boot firmware (BIOS etc) mucking
> with it, leaving it in any of several states that are
> not otherwise documented for resume() paths.

I do not think that S4 ad S5 differ in this regard. During resume, you
go through normal boot in both cases, bootloader, linux-kernel boot.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
