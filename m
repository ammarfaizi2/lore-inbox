Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVC1N4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVC1N4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVC1Nzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:55:52 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:4331 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261802AbVC1NrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:47:03 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-os@analogic.com
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <Pine.LNX.4.61.0503280727310.19644@chaos.analogic.com>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
	 <1112011441.27381.31.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0503280727310.19644@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 28 Mar 2005 08:46:02 -0500
Message-Id: <1112017562.27381.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 08:12 -0500, linux-os wrote:
> On Mon, 28 Mar 2005, Steven Rostedt wrote:

> Following the flock in this GPL issue insulates you from
> many future changes in the kernel. Major portions of the
> module code has already been rewritten to erect a solid
> barrier, marking what's in the kernel and what's without.
> What used to be done outside the kernel, the only reasonable
> place to do it, has now been moved inside the kernel for no
> other reason but isolation.
> 
> So tell your senior staff that you need to include the
> GPL license with your code. If you write good code, the
> chances of anybody outside your company actually reading
> it is near zero. If your "trade secrets" are so obvious
> that a look at the code will reveal them, you really need
> to get another job, your company will disappear in a
> month or two.

I first started on this thread because of NVidia. Since I have many
machines that use nvidia drivers and I suffer the consequences of this,
but I'm a kernel programmer and can get around this too. 

But now you hit on something that I'm fighting with.  I may be part of
the GPL religion, but I'm not a true believer.  I like the concept. All
code that I write on my own time is usually LGPL (otherwise it is just
public use). I like to share and share alike. But the problem I have is
that I don't have senior management. I'm a free lance programmer. I have
companies (my customers) pay me to code. I can refuse to code if I don't
agree with them, but then they get someone else and I go hungry. I
strongly recommend to them that it is in their interest to release the
code I write under GPL, but the managers don't see it. I may not be that
strong of a spokesman, but they don't like to listen to me, the just
tell me, do what we pay you to do. Like I said, I'm not a strong
believer, so I won't risk not being able to feed my family for the FSF
cause. So I just go on and code, and let their lawyers figure out what
to do. 

The customers I work for are actually more interested in selling their
hardware than the software. But when they spend a lot of money to code
for their hardware, they find it hard to understand that it is best to
give it up as GPL code, especially when the workings of the hardware are
explicit in the code. I usually have to also make changes to the kernel
to handle the situation (which all goes under the GPL of course), so the
modules I write are never expected to be used by the vanilla kernel, or
by anyone elses kernel for that matter. The kernel is made to run on
special hardware, and then have some special extensions put on that are
in the form of modules. I'm still in the process of fighting to get
these under GPL, but I'm not an employee, I'm a vendor. And the
management sees me as such. It's very easy for them to pull the plug on
me and find another approach to go. 

These companies are rather large, and sell things for a niche market,
that usually don't care about fighting for the GPL. This is not NVidia
selling video cards to consumers. This is large companies selling larger
systems to other large companies, and my part is just a small one. So, I
don't think they'll disappear simply because they don't put everything
under the GPL. They are smart enough to keep the extensions under GPL
and allow me to send fixes if I find a bug with the code back to the
maintainer. So the maintainer still benefits from this in the form of
testing and updates.

The one way I do try to fight for the GPL is always make the imbedded
code more efficient than the modules. So, to keep the code proprietary
always has a impact on performance. This isn't hard to do, since
obviously the code that is imbedded would be more efficient than code
that needs to be called indirectly through hooks. Nothing has been
decided yet, but if the benchmarks hold out, it all may be under GPL in
the end anyway.

-- Steve


