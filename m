Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUL0XSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUL0XSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUL0XSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:18:20 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:21798 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261892AbUL0XSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:18:16 -0500
Date: Tue, 28 Dec 2004 00:19:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Georg Prenner <georg.prenner@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: make errors (make clean, make menuconfig) make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
Message-ID: <20041227231934.GA9251@mars.ravnborg.org>
Mail-Followup-To: Georg Prenner <georg.prenner@aon.at>,
	linux-kernel@vger.kernel.org
References: <41D08472.6010404@aon.at> <20041227224833.GA8206@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227224833.GA8206@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 11:48:33PM +0100, Sam Ravnborg wrote:
> > I am having a problem when executing "make menuconfig" on my fresh 
> > extracted 2.6.10 kernel.
> > 
> > The error message is like this:
> > 
> > make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> > make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> > make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
> > make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
...

It is the following code snippet that causes the troubles:
---
outputmakefile:
        $(Q)if /usr/bin/env test ! $(srctree) -ef $(objtree); then \
        $(CONFIG_SHELL) $(srctree)/scripts/mkmakefile
---

I've now tried differents way to reproduce the error without luck.
You are the second person reporting this - and I assumed from fitst
poster this was a symlink issue. But I cannot reporduce it here.

One person coul not locate /usr/bin/env - but that did not trigger
anythin renaming that file to something else.

Could you please drop a mail with full log what you do before seeing
this bug.

	Sam

