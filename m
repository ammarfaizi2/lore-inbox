Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUHPUUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUHPUUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267937AbUHPUUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:20:10 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:12390 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267936AbUHPUUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:20:05 -0400
Date: Tue, 17 Aug 2004 00:20:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild + kconfig: Updates
Message-ID: <20040816222005.GB24450@mars.ravnborg.org>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org> <20040815204229.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040816204550.GA20956@mars.ravnborg.org> <20040816200159.GK12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816200159.GK12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 09:01:59PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Aug 16, 2004 at 10:45:50PM +0200, Sam Ravnborg wrote:
> >  $(single-used-m): %.o: %.c FORCE
> > +	$(cmd_force_checksrc)
> >  	$(call if_changed_rule,cc_o_c)
> >  	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
> >  
> > 
> > That should do it?
> > I will push this if you are OK with it.
> 
> Uhh...  It ends up running sparse *twice* and still runs gcc on every
> file.


You are supposed to use: make C=2 only on a fully updated tree.
Then you will see sparse only being run once, and gcc will not be run
because the file is already updated.

That said it should not run sparse twice when a file needs to be updated.
Will take another look at it.


PS. Please keep me in cc:.

	Sam
