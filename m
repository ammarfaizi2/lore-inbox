Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWJUAbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWJUAbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWJUAbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:31:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161159AbWJUAba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:31:30 -0400
Date: Fri, 20 Oct 2006 17:31:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@suse.cz>
cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.4.3
In-Reply-To: <20061021002251.GO20017@pasky.or.cz>
Message-ID: <Pine.LNX.4.64.0610201728031.3962@g5.osdl.org>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021002251.GO20017@pasky.or.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Oct 2006, Petr Baudis wrote:
>
> > That said, "LESS=FRS" doesn't really help that much. It still clears the 
> > screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
> > is actually nice _if_ the pager is used.
> 
> Hmm, what terminal emulator do you use? The reasonable ones should
> restore the original screen. At least xterm does, and I *think*
> gnome-terminal does too (although I'm too lazy to boot up my notebook
> and confirm).

Not xterm, at least.

Not gnome-terminal either, for that matter.

I just tried.

	LESS=FRS git diff

clears the screen and leaves the thing at the end.

	LESS=FRSX git diff

works fine, but for people who _like_ the alternate screens (and I do, 
once I really use a pager) it also disables the alternate screen.

It might depend on the termcap, of course. I'm running FC5.

		Linus
