Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbUAPQIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUAPQIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:08:51 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:9600 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265626AbUAPQIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:08:49 -0500
Date: Fri, 16 Jan 2004 17:08:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>,
       Eric Youngdale <ericy@cais.com>
Subject: Re: [PATCH] stronger ELF sanity checks v2
Message-ID: <20040116160841.GA302@elf.ucw.cz>
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk> <20040113033234.GD2000@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113033234.GD2000@vitelus.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> > Here's the second version of my patch to add better sanity checks for
> > binfmt_elf
> 
> I assume this breaks Brian Raiter's tiny ELF executables[1]. Even
> though these binaries are evil hacks that don't comply to standards
> and serve no serious purpose, I'm not sure what the purpose of the
> sanity checks is. Are there any risks associated with running
> non-compliant ELF executables? (Now that I mention it, the

You get vy ugly behaviour. If you compile executable with huge static
data, it will compile okay, link okay, *launch okay* and die on
segfault. That's wrong, it should have died on -ENOMEM during exec.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
