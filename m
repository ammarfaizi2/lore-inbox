Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTELWXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTELWXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:23:53 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:59406 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S262858AbTELWXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:23:51 -0400
Date: Tue, 13 May 2003 00:36:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tomas Szepe <szepe@pinerecords.com>
cc: Dave Jones <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new kconfig goodies
In-Reply-To: <20030512160029.GJ5376@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0305122257320.5042-100000@serv>
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
 <20030512143207.GA6459@suse.de> <20030512160029.GJ5376@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 May 2003, Tomas Szepe wrote:

> Also, will the config system let the user know that their having
> enabled a certain option has affected other options (possibly in
> different submenus)?

The user will see that he can't disable certain options.
This is basically the same problem as with other dependencies, if the user 
selects an option other options may become visible. There is no direct 
information, how the config option depend on each other (except xconfig 
offers that as a debug option).

>  As things work now, there's no way to tell
> if an option has been switched on "by dependency," so in the above
> example, in switching GART_IOMMU off after its switching on has
> enabled AGP, the system won't know to disable AGP again.  I'm not
> convinced this is a nice feature in fact. :)  Maybe we just need
> something like grayed-out entries with a comment, for instance:
> 
> /* [ ] IOMMU support (needs "/dev/agpgard (AGP Support)") */

Of course the same can be done with normal dependencies, but this new 
option offers more flexibility. Important options don't have to be hidden 
away behind a lot of dependencies. I'm aware that this can be abused, so I 
have to watch a bit how it will be used.

bye, Roman

