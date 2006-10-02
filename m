Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWJBHIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWJBHIT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 03:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWJBHIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 03:08:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50076 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932398AbWJBHIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 03:08:19 -0400
Date: Mon, 2 Oct 2006 09:08:08 +0200 (MEST)
Message-Id: <200610020708.k92788Th007608@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: akpm@osdl.org, rdunlap@xenotime.net
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Cc: linux-kernel@vger.kernel.org, rossb@google.com, sam@ravnborg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 18:17:02 -0700, Randy Dunlap wrote:
> > > > The patch titled
> > > > 
> > > >      allow /proc/config.gz to be built as a module
> > > > 
> > > > has been added to the -mm tree.  Its filename is
...
> Can any of the distro people chime in here?  Andrew merged this
> patch to mainline today.  Several people had disagreed with merging
> it, but now Andrew says we need more discussion (if or) in order to
> revert it.

Merged into -mm or not, modular /proc/config.gz remains an
utterly redundant kernel feature that user-space doesn't need.

User-space knows how to locate modules for the running kernel,
including the module implementing /proc/config.gz; therefore
it can replace the module file with the corresponding config
data, without loss of functionality.

All that's needed is to standardise the location of the
config file; /lib/modules/`uname -r`/config.gz seems a
reasonable choice.
