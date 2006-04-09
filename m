Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWDIP0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWDIP0T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDIP0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:26:18 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27050 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750764AbWDIP0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:26:18 -0400
Date: Sun, 9 Apr 2006 17:26:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/19] kconfig patches
Message-ID: <Pine.LNX.4.64.0604091628240.21970@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a batch of kconfig (and also some kbuild related) patches. The 
first four patches I'd like to see to go into 2.6.17 if possible. Although 
I'm quite confident about the remaining patches, a bit more testing can't 
hurt.

Some comments about the most interesting aspects from a user perspective 
for these patches:

Now it's possible to do something like "vi .config; make" and be 
reasonably certain it does the right thing, before especially kbuild 
related config changes were not correctly picked up by make and required 
an explicit "make oldconfig".

Andrew, what might be very interesting for you is that kconfig is not 
rewriting .config anymore all the time by itself and if you set 
KCONFIG_NOSILENTUPDATE you can even omit the silent updates, so unless you 
explicitly call one of the config targets, you can be sure kbuild won't 
touch your .config symlink anymore and as long as the .config is in sync 
with the Kconfig files you shouldn't see a difference. I'm very interested 
how that works for you.

Another interesting feature are the xconfig changes, it supports now a 
search option like menuconfig and the help output links to other symbols, 
so one can basically browse through the kconfig info. The latter is still 
a bit experimental, so it's only visible if the debug info option is 
enabled.

bye, Roman
