Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWGGUhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWGGUhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWGGUhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:37:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:8601 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751244AbWGGUhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:37:17 -0400
Date: Fri, 7 Jul 2006 22:36:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 build error (YACC): followup
Message-ID: <20060707203658.GA16217@mars.ravnborg.org>
References: <20060707202442.DA2AFDBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707202442.DA2AFDBA1@gherkin.frus.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 03:24:42PM -0500, Bob Tracy wrote:
> I wrote:
> >$YACC now seems to be undefined when I do a "make bzImage" and the
> >build process gets to drivers/scsi/aic7xxx/aicasm (with the aic7xxx
> >driver configured as a built-in).  As a workaround, it's possible to
> >"cd" into the indicated directory and run "make" directly.  Once the
> >default build completes, restarting "make bzImage" from the kernel
> >source root continues as expected.
> 
> Found it.  The main "Makefile" has "MAKEFLAGS += -rR" uncommented as
> of 2.6.18-rc1.  The deleted comment about "possibly random breakage"
> that used to be just above that line pretty much says it all :-).
Translated: aic7xxx must supply its own definition of YACC or we should
put it in the top-level Makefile.

kbuild no longer rely on the predefined variables in make.

	Sam
