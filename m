Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUJPU11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUJPU11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUJPU11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:27:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:30756 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268848AbUJPU1Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:27:24 -0400
Date: Sun, 17 Oct 2004 00:27:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, olh@suse.de, akpm@osdl.org
Subject: Re: [PATCH] kconfig: OVERRIDE: save kernel version in .config file
Message-ID: <20041016222727.GG8765@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, olh@suse.de, akpm@osdl.org
References: <20040917154346.GA15156@suse.de> <20040917102024.50188756.rddunlap@osdl.org> <20040917104334.1b7d7d19.rddunlap@osdl.org> <20041016212859.GC8765@mars.ravnborg.org> <Pine.LNX.4.61.0410162206560.7182@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410162206560.7182@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 10:18:35PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Sat, 16 Oct 2004, Sam Ravnborg wrote:
> 
> > Applied - but I named it KCONFIG_TIMESTAMP so people would not
> > think that kbuild suddenly stopped checking timestamps.
> 
> That reminds me, I'm not really happy with this patch, it's a hack not a 
> real solution, either we save the timestamp always or not at all, making 
> it dependent on an environment variable is IMO ugly.
> I have a patch which does some tighter checking during config loading, 
> which can be used whether it's needed to write the config. Other front 
> ends could use this as well (e.g. xconfig right now always ask to save
> the config).

The better approach for sure. When we have this in place I will
delete the KCONFIG_NOTIMESTMAP hack.

	Sam
