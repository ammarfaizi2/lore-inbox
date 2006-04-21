Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWDUHcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWDUHcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWDUHcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:32:17 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:21261 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751272AbWDUHcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:32:17 -0400
Date: Fri, 21 Apr 2006 09:32:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Roskin <proski@gnu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Removing .tmp_versions considered harmful
Message-ID: <20060421073216.GA17492@mars.ravnborg.org>
References: <1145593342.2904.30.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145593342.2904.30.camel@dv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 12:22:22AM -0400, Pavel Roskin wrote:
> Hello!
> 
> A patch applied shortly after Linux 2.6.16
> (fb3cbd2e575f9ac0700bfa1e7cb9f4119fbd0abd in git) causes
> the .tmp_versions directory to be removed every time make is run to
> build external modules.
> 
> 
> 2) The projects where modules are build in more than one directory (such
> as MadWifi) are now compiled with spurious warnings about unresolved
> symbols.  This happens because every module is compiled individually,
> and the *.mod files for one module are removed before the other is
> compiled.

Then fix madwifi so it builds modules as documented in
Documentation/kbuild/modules.txt
See: --- 5.3 External modules using several directories

As with many other external modules madwifi contains a lot of ugly
makefile hackery - and if done as documentated it gets so much simpler.
I'm aware that 2-4 support complicates things a little but if people
made it be slimm and nice for 2.6 and _then_ added 2.4 supporrrrrrrrrrit
woulllllld be much simpler.
It seems that people keep all the hackery for 2.4 and does a bad job
adapting to 2.6.

All the bad FAQ's out there does a good job confusing people.
Almost no-one mention SUBDIRS= as is preferred with 2.4 but seldom used
:-(

	Sam
