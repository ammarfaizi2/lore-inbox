Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755889AbWKRCbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbWKRCbe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 21:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756158AbWKRCbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 21:31:34 -0500
Received: from raven.upol.cz ([158.194.120.4]:48370 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1755889AbWKRCbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 21:31:33 -0500
Date: Sat, 18 Nov 2006 02:38:32 +0000
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Message-ID: <20061118023832.GG13827@flower.upol.cz>
References: <20061118010946.GB31268@vanheusden.com> <slrnelsomr.dd3.olecom@flower.upol.cz> <20061118020200.GC31268@vanheusden.com> <20061118020413.GD31268@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061118020413.GD31268@vanheusden.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 03:04:13AM +0100, Folkert van Heusden wrote:
> > > > I found that sometimes processes disappear on some heavily used system
> > > > of mine without any logging. So I've written a patch against 2.6.18.2
> > > > which emits logging when a process emits a fatal signal.
> > > Why not to patch default signal handlers in glibc, to have not only
> > > stderr, but syslog, or /dev/kmsg copy of fatal messages?
> > Afaik when a proces gets shot because of a segfault, also the libraries
> > it used are shot so to say. iirc some of the more fatal signals are
> > handled directly by the kernel.

Kernel sends signals, no doubt.

Then, who you think prints that "Killed" or "Segmentation fault"
messages in *stderr*?
[Hint: libc's default signal handler (man 2 signal).]

> Also: what about statically build programs?

"-lc" embeds libc in static binary, no?

IMHO it's not a lkml issue. Here are many who would say you, that userspace
preblems are userspace problems.
____
