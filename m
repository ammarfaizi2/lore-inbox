Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVA0TyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVA0TyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVA0TyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:54:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23748 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262714AbVA0Txp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:53:45 -0500
Date: Thu, 27 Jan 2005 20:53:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org
Subject: Re: Patch 1/6  introduce sysctl
Message-ID: <20050127195332.GA12532@elte.hu>
References: <20050127101117.GA9760@infradead.org> <20050127101201.GB9760@infradead.org> <20050127181525.GA4784@elf.ucw.cz> <20050127191120.GA10460@elte.hu> <20050127194603.GA31127@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127194603.GA31127@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

> On Thu, Jan 27, 2005 at 08:11:20PM +0100, Ingo Molnar wrote:
> 
>  > so, i'm glad to report, it's a non-issue. Sometimes developers want to
>  > disable randomisation during development (quick'n'easy hacks get quicker
>  > and easier - e.g. if you watch an address within gdb), so having the
>  > capability for unprivileged users to disable randomisation on the fly is
>  > useful and Fedora certainly offers that, but from a support and
>  > bug-reporting POV it's not a problem.
> 
> It's worth noting that some users have found the randomisation disable
> useful for running things like xine/mplayer etc with win32 codecs that
> seem to just segfault otherwise.  These things seem to be incredibly
> fragile to address space layout changes, which is a good argument for
> trying to avoid these wierdo formats where possible in favour of free
> codecs.

yes, this was by far the biggest problem randomisation caused. Note that
while Fedora offers a personality-hack to disable randomisation on the
fly, which Wine could have made use of to have the fix automatically;
Alexandre didnt want to rely on it in Wine because that flag's semantics
(PER_LINUX32) were not upstream. (and i very much agree with Alexandre
on that call).

But once something like this is upstream i believe Wine can (and will)
have a robust legacy-binary-format loader that is not affected by
randomisation effects, with minimal changes.

	Ingo
