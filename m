Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVHHWcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVHHWcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVHHWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:32:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38928 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932314AbVHHWcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:32:12 -0400
Date: Tue, 9 Aug 2005 00:32:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Haninger <ahaning@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>,
       "Adam J. Richter" <adam@yggdrasil.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Compiling module-init-tools versions after v3.0
Message-ID: <20050808223209.GL4006@stusta.de>
References: <105c793f050808150810784ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f050808150810784ef3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 06:08:57PM -0400, Andrew Haninger wrote:

> Hello.


Hi Andrew,


> I'm trying to upgrade one of my machines to module-init-tools-3.2-pre8
> so that I can better assist a driver developer in debugging some
> issues with the OPL3SA2 driver from ALSA.
> 
> The machine is currently running a slightly-modified Slackware 9.1
> distribution (I've updated several packages to support the 2.6 kernel
> and other upgrades since the first install). I currently have
> module-init-tools 3.0 installed but I'd like to install version
> 3.2-pre8.
> 
> The problem is that compiling module-init-tools versions after 3.0
> seem require docbook-utils (the compile fails on a docbook2man
> operation) to be installed and docbook-utils requires jade which will
> not compile. I found one jade package called jade-1.2.1 (from '98 or
> '99) which will not compile. I tried openjade, but it does not seem to
> work when compiling docbook-tools (I made a symlink from the openjade
> binary to "jade").
> 
> Is there some other package that I'm overlooking that's required to
> get docbook-utils installed?  If not, how have other people compiled
> and installed newer versions of module-init-tools?


Workaround:

Remove the

  man_MANS = $(MAN5) $(MAN8)

line in Makefile.in before running configure.


But this could be better handled in module-init-tools.


> Thanks.
> 
> -Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

