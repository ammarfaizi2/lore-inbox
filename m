Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUJPTgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUJPTgs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUJPTgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:36:31 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:61271 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266679AbUJPT26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:28:58 -0400
Date: Sat, 16 Oct 2004 23:29:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, olh@suse.de, akpm@osdl.org,
       sam@ravnborg.org
Subject: Re: [PATCH] kconfig: OVERRIDE: save kernel version in .config file
Message-ID: <20041016212859.GC8765@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, olh@suse.de, akpm@osdl.org,
	sam@ravnborg.org
References: <20040917154346.GA15156@suse.de> <20040917102024.50188756.rddunlap@osdl.org> <20040917104334.1b7d7d19.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917104334.1b7d7d19.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 10:43:34AM -0700, Randy.Dunlap wrote:
> On Fri, 17 Sep 2004 10:20:24 -0700 Randy.Dunlap wrote:
> 
> | On Fri, 17 Sep 2004 17:43:46 +0200 Olaf Hering wrote:
> | 
> | | Randy,
> | | 
> | | we need a way to turn the timestamp off when running make oldconfig.
> | | Running make oldconfig gives always a delta, even if the .config is
> | | unchanged. This is bad for cvs repos, it generates conflicts now if 2
> | | people work on the same config file.
> | | Please provide a patch to not call ctime if a non-empty enviroment
> | | variable of your choice is set.
> | 
> | How's this?
> 
> Let's be a little safer in checking "NOTIMESTAMP".
> 
> Omit .config file timestamp in the file if the environment variable
> "NOTIMESTAMP" exists and is non-null.
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Applied - but I named it KCONFIG_TIMESTAMP so people would not
think that kbuild suddenly stopped checking timestamps.

	Sam
