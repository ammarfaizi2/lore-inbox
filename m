Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751743AbWJIJqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbWJIJqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 05:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWJIJqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 05:46:19 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:6027 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751740AbWJIJqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 05:46:18 -0400
Date: Mon, 9 Oct 2006 11:46:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roger While <simrw@sim-basis.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: menuconfig bust in 2.6.19rc1-git5
Message-ID: <20061009094609.GA6703@uranus.ravnborg.org>
References: <6.1.1.1.2.20061009092219.02b0bec0@192.168.6.12>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.2.20061009092219.02b0bec0@192.168.6.12>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:30:06AM +0200, Roger While wrote:
> > make menuconfig
> HOSTCC  scripts/basic/fixdep
> HOSTCC  scripts/basic/docproc
> HOSTCC  scripts/kconfig/conf.o
> HOSTCC  scripts/kconfig/kxgettext.o
> HOSTCC  scripts/kconfig/lxdialog/checklist.o
> In file included from scripts/kconfig/lxdialog/checklist.c:24:
> scripts/kconfig/lxdialog/dialog.h:96: error: syntax error before "chtype"
> scripts/kconfig/lxdialog/dialog.h:96: warning: no semicolon at end of 
> struct or union

This looks like some type is missing.
I do not expect to be within reach of my linux box the next week - du you have
the possibility to try a few thing to sort it out?

Take a look at line 96 (and one or two lines before) and check what type
is used there. Then try to find out in which header file
it is supposed to be defined and include this header file in dialog.h.

This should keep you going again.

It may also be that you need to install a later version of ncurses to get it operational.

	Sam
