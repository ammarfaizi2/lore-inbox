Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVA0TyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVA0TyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVA0TyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:54:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6414 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262715AbVA0Txt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:53:49 -0500
Subject: Re: Patch 1/6  introduce sysctl
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <20050127194603.GA31127@redhat.com>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101201.GB9760@infradead.org> <20050127181525.GA4784@elf.ucw.cz>
	 <20050127191120.GA10460@elte.hu>  <20050127194603.GA31127@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 20:53:36 +0100
Message-Id: <1106855616.5624.125.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 14:46 -0500, Dave Jones wrote:
> On Thu, Jan 27, 2005 at 08:11:20PM +0100, Ingo Molnar wrote:
> 
>  > so, i'm glad to report, it's a non-issue. Sometimes developers want to
>  > disable randomisation during development (quick'n'easy hacks get quicker
>  > and easier - e.g. if you watch an address within gdb), so having the
>  > capability for unprivileged users to disable randomisation on the fly is
>  > useful and Fedora certainly offers that, but from a support and
>  > bug-reporting POV it's not a problem.
> 
> It's worth noting that some users have found the randomisation disable useful
> for running things like xine/mplayer etc with win32 codecs that seem
> to just segfault otherwise.  These things seem to be incredibly fragile
> to address space layout changes, which is a good argument for trying to
> avoid these wierdo formats where possible in favour of free codecs.

actually that's because windows has a different initial stack alignment
that wine compensates but I guess xine/mplayer don't.
with p4's you get that anyway (and glibc and ..)



