Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbUCXKZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 05:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbUCXKZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 05:25:25 -0500
Received: from gprs214-213.eurotel.cz ([160.218.214.213]:38529 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263281AbUCXKZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 05:25:15 -0500
Date: Wed, 24 Mar 2004 11:22:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Jonathan Sambrook <swsusp@hmmn.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040324102233.GC512@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403232352.58066.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 23-03-04 23:52:58, Dmitry Torokhov wrote:
> On Tuesday 23 March 2004 06:32 pm, Pavel Machek wrote:
> > Well, I'd hate
> > 
> > Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
> > Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
> > 
> > to be obscured by progress bar.
> 
> OK, so you have an error condition on your CD. Does it prevent suspend from
> completing? If not then I probably would not care about it till later when
> I see it in syslog... I remember that the one thing that Pat
> complained

Except when it is not in syslog, because it was after atomic copy or
before atomic copy back. swsusp is pretty unique in this respect.

> most often is your love for "panic"ing instead of trying to recover. In that
> case you understandably want as many preceding messages as possible left
> intact on the screen to diagnose the problem. If error recovery is ever done
> then some eye-candy probably won't hurt.

Except when error recovery does not work.

> Also, if we leave swsusp and suspending alone for a second, I could have
> 'top' running on console overwriting the very same messages. Should we ban
> top?

Its bad idea to run top when kernel messages are not redirected
somewhere. Unfortunately eye-candy makes that choice for you, and does
the wrong thing automatically.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
