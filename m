Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265723AbTIJUNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTIJUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:13:24 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:16138 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265723AbTIJUNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:13:22 -0400
Date: Wed, 10 Sep 2003 22:13:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Build minimum in scripts/ when changing configuration
Message-ID: <20030910201320.GA5852@mars.ravnborg.org>
Mail-Followup-To: Ricky Beam <jfbeam@bluetronic.net>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20030910191758.GC5604@mars.ravnborg.org> <Pine.GSO.4.33.0309101555590.13584-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0309101555590.13584-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 03:58:02PM -0400, Ricky Beam wrote:
> On Wed, 10 Sep 2003, Sam Ravnborg wrote:
> >+scripts/fixdep:
> >+	$(Q)$(MAKE) $(build)=scripts $@
> >+
> 
> Umm, that still doesn't address the "already up to date" make will generate
> when fixdep doesn't need to be rebuilt. (which is why I changed things the
> way I did.)
I am aware of that.
It does not happen in the usual situations where it would have become
visible.
One example is "make oldconfig" where it appears, but there is so much 
other output that I avoided to introduce special support to avoid it.

You see the same with asm-offset.h. We could avoid that with a hack
in Makefile.build, but I have resisted to do it, again to avoid special cases.

	Sam
