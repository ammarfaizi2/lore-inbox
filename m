Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUIATVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUIATVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUIATVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:21:00 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36244 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267417AbUIATUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:20:52 -0400
Date: Wed, 1 Sep 2004 21:23:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm2
Message-ID: <20040901192303.GB7219@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040830235426.441f5b51.akpm@osdl.org> <200408311454.48673.gene.heskett@verizon.net> <20040831194135.GB19724@mars.ravnborg.org> <20040901173509.GC19730@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901173509.GC19730@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:35:09AM -0700, Tom Rini wrote:
  
> > -__modules := $(sort $(shell grep -h .ko /dev/null $(wildcard $(MODVERDIR)/*.mod)))
> > +__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
> >  modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
> >  
> >  .PHONY: $(modules)
> 
> D'oh...  Wouldn't .modpost need the same change?

Even worse. I already did the same change for modpost - without
fixing it for modinst :-(

The modpost change is part of the bk-kbuild.patch

	Sam
