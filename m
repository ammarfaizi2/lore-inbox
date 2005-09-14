Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbVINQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVINQzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVINQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:55:37 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:56613 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030277AbVINQzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:55:36 -0400
Date: Wed, 14 Sep 2005 18:58:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Message-ID: <20050914165812.GA9096@mars.ravnborg.org>
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net> <20050914164953.GA7480@mars.ravnborg.org> <20050914175326.C30746@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914175326.C30746@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 05:53:26PM +0100, Russell King wrote:
> On Wed, Sep 14, 2005 at 06:49:53PM +0200, Sam Ravnborg wrote:
> > >  # Use LINUXINCLUDE when you must reference the include/ directory.
> > >  # Needed to be compatible with the O= option
> > >  LINUXINCLUDE    := -Iinclude \
> > > -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> > > +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> > > +		   -imacros include/linux/autoconf.h
> > >  
> > What is the purpose of using -imacros instead of -iinclude
> > 
> > o -iinclude is much more commonly used for this purpose.
> > o sparse has limited support(*) for -iinclude today
> > o -imacros will silently ignore any output caused by the file
> 
> autoconf.h should only be macro definitions and should not contain
> any code, so -imacros seemed to be the correct tool for the job.

I will use -iinclude for a start. When sparse has supported -imacros
in a few weeks we can change it if we like. I will update the patch.

	Sam
