Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUJPUTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUJPUTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJPUT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:19:29 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7819 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268817AbUJPUTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:19:01 -0400
Date: Sat, 16 Oct 2004 22:18:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH] kconfig: OVERRIDE: save kernel version in .config file
In-Reply-To: <20041016212859.GC8765@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0410162206560.7182@scrub.home>
References: <20040917154346.GA15156@suse.de> <20040917102024.50188756.rddunlap@osdl.org>
 <20040917104334.1b7d7d19.rddunlap@osdl.org> <20041016212859.GC8765@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 16 Oct 2004, Sam Ravnborg wrote:

> Applied - but I named it KCONFIG_TIMESTAMP so people would not
> think that kbuild suddenly stopped checking timestamps.

That reminds me, I'm not really happy with this patch, it's a hack not a 
real solution, either we save the timestamp always or not at all, making 
it dependent on an environment variable is IMO ugly.
I have a patch which does some tighter checking during config loading, 
which can be used whether it's needed to write the config. Other front 
ends could use this as well (e.g. xconfig right now always ask to save
the config).

bye, Roman
