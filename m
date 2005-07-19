Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVGSUuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVGSUuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVGSUuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:50:03 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:28348 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261607AbVGSUuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:50:01 -0400
Date: Tue, 19 Jul 2005 22:50:53 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Bodo Eggert <7eggert@gmx.de>, perex@suse.cz, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [2.6 patch] sound drivers select'ing ISAPNP must depend on PNP
 && ISA
In-Reply-To: <20050719163640.GK5031@stusta.de>
Message-ID: <Pine.LNX.4.58.0507192232230.4182@be1.lrz>
References: <Pine.LNX.4.58.0507171702030.12446@be1.lrz> <20050719163640.GK5031@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2005, Adrian Bunk wrote:
> On Sun, Jul 17, 2005 at 05:07:48PM +0200, Bodo Eggert wrote:

> > In sound/isa/Kconfig, select ISAPNP and depend on ISAPNP are intermixed, 
> > resulting in funny behaviour. (Soundcarts get selectable if other 
> > soundcards are selected).
> > 
> > This patch changes the "depend on ISAPNP"s to select.
> >...
> 
> I like the idea of this patch, but it brings to more drivers to a 
> violation of the "if you select something, you have to ensure that the 
> dependencies of what you select are fulfilled" rule causing link errors 
> with invalid .config's.

That should be mentioned in kconfig-language.txt. OTOH, the build system
should automatically propagate the dependencies. I asume that should be
easy, except for having the time to implement that.


BTW: How can you select something to be at least a module?
BTW2: In bool options, depending on FOO seems to be equal to depending on 
      FOO!=n. Is this assumption correct?

-- 
Top 100 things you don't want the sysadmin to say:
49. What's this switch for anyways...?
