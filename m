Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUCXK1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbUCXK1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:27:09 -0500
Received: from gprs214-213.eurotel.cz ([160.218.214.213]:44929 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263280AbUCXK0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:26:46 -0500
Date: Wed, 24 Mar 2004 11:26:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: ncunningham@users.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324102632.GD512@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au> <opr5cry20s4evsfm@smtp.pacific.net.th> <1080107188.2205.10.camel@laptop-linux.wpcb.org.au> <opr5cu6ngl4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr5cu6ngl4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >On Wed, 2004-03-24 at 18:22, Michael Frank wrote:
> >>Error messages should be handled on a seperate VT eliminating the issue.
> >
> >While I definitely like the idea, I'm not sure that's feasible; as Pavel
> >pointed out, Suspend doesn't generate all the error messages that might
> >possibly appear. Maybe I'm just ignorant.. I'll take a look when I get
> >the change.
> 
> printk is central and could do the switch when swsusp is active

You *could* do it, but it is bad idea. You don't want to patch
printk.c, that driver printk could be done from interrupt (and you
can't switch consoles at that point), you loose context, etc. What
about doing the simple thing, maybe hack with CRs and be done with
that?

If someone wants more eye candy, they have to patch their kernel with
bootsplash.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
