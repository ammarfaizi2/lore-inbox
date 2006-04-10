Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWDJIq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDJIq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 04:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWDJIq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 04:46:28 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:46512 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751098AbWDJIq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 04:46:27 -0400
Date: Mon, 10 Apr 2006 10:46:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 0/19] kconfig patches
In-Reply-To: <20060409235548.52b563a9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604101035240.32445@scrub.home>
References: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
 <20060409235548.52b563a9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Andrew Morton wrote:

> > Andrew, what might be very interesting for you is that kconfig is not 
> >  rewriting .config anymore all the time by itself and if you set 
> >  KCONFIG_NOSILENTUPDATE you can even omit the silent updates, so unless you 
> >  explicitly call one of the config targets, you can be sure kbuild won't 
> >  touch your .config symlink anymore and as long as the .config is in sync 
> >  with the Kconfig files you shouldn't see a difference. I'm very interested 
> >  how that works for you.
> 
> Badly, sorry.  `make oldconfig' blows away the .config symlink.

I know, that's why I said "unless you explicitly call one of the config 
targets", "make silentoldconfig" is the only exception, but this one is 
already implicitly called during a kbuild when something changed.
If you call "make oldconfig", you have to restore the symlink manually.

bye, Roman
