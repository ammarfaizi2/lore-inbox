Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRH0Uru>; Mon, 27 Aug 2001 16:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRH0Url>; Mon, 27 Aug 2001 16:47:41 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:43268 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S268861AbRH0Urc>; Mon, 27 Aug 2001 16:47:32 -0400
Message-ID: <3B8AB21B.444F868A@netvision.net.il>
Date: Mon, 27 Aug 2001 23:48:27 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Keyboard and PS/2 mouse lockups
In-Reply-To: <3B88F25B.8AF25EF9@netvision.net.il>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ben-Gershon wrote:
> 
> I know this is not new, but I feel that my input is worth
> noting.
> 
> I recently upgraded my hardware from a Tyan board with a PII 333
> to an ASUS P4T with a P4 1.5G.
> 
> Running either kernel 2.2.19 or 2.4.6, 2.4.7, 2.4.8, 2.4.9, I get
> a serious conflict between the PS/2 mouse and the keyboard. If the
> mouse is plugged into the machine and generates any mouse event (by
> moving it or clicking) the keyboard is completely locked up. I am
> using a KVM (=kbd-video-mouse) splitter box, and the strange thing
> is that the box will respond to a 'double scroll lock' keypress to
> switch from one machine to the next, but if the kbd is locked up by
> the above trouble it will not respond at all, and the manual switching
> button must be used. This is very strange, as the 'double scroll lock'
> action works even if the currently selected machine is switched off!
> 
> I get the lockup whether or not gpm is running, and even if the
> kernel is built with no PS/2 mouse support. If the mouse is removed
> before the trouble is triggered, all is OK.

That seems to be the problem! If the kernel is compiled without
busmouse support, and with PS/2 mouse support, then the mouse is
recognised and the keyboard does not get locked up.

This is, therefore, a warning to all:

Even if you are configuring a system with no need for a mouse (as
I had been doing until now - a system console for a server, and no
local X-server required) YOU MUST CONFIGURE THE KERNEL WITH THE
PS/2 MOUSE DRIVER (and NOT as a module) or else you are likely
to suffer the consequences!

Michael Ben-Gershon
mybg@netvision.net.il
