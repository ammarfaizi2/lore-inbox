Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752588AbWKBUQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbWKBUQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbWKBUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:16:52 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:52401 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1752588AbWKBUQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:16:51 -0500
Date: Thu, 2 Nov 2006 21:16:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>,
       Jesper Juhl <jesper.juhl@gmail.com>, trivial@kernel.org
Subject: Re: [patch] make the Makefile mostly stay within col 80
Message-ID: <20061102201650.GA9237@uranus.ravnborg.org>
References: <200611020047.53658.jesper.juhl@gmail.com> <slrnekj6ps.2in.olecom@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnekj6ps.2in.olecom@flower.upol.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 07:16:12AM +0000, Oleg Verych wrote:
> 
> On 2006-11-01, Jesper Juhl wrote:
> > Trivial little thing really. 
> > Try to make most of the Makefile obey the 80 column width rule.
> 
> I'm already working on it. I did a lot more stuff, but currently i'm
> stuck with very first patch, i've tried to push to mister Andrew:
> <http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116198944205036&w=2>
> 
> As i'm using emacs, i cann't revert this open/save/close patch every
> time. If someone with RH-based distro is willing to help, i'll be glad.
> Version of make is Red Hat make-3.80-10.2.
> 
> Also, i want Sam Ravnborg to comment on that effort (e-mail added). Thanks.

Most of the time I spent on Linux development is in a 80xsomething so
I support the effort to make it fit into 80 coloumn.
But only if done sensible and not as a hard rule. Some stuff really
is less readable if it is adjusted to fit into a 80 coloumn.

I do not support tabifying the Makefiles. In a makefile <tab> has
a special interpretation and the rule of thumb is:

1) Use tab to indent commands as make requires it
2) Commands spanning more than one line may be indented with tabs.

Avoid tabs in all other places.

This is not the same ruleset as used in the .c source but the difference
here is that an assignment is not turned into a command in .c code
just because it is prefixed by a tab.

At present I'm fed up with day time job that is almost around the clock
time job. It will take a month before I will be active in kbuild area
again so please be patient. If something really urgent shows up I
can act - but just not much time to do so in.

	Sam

