Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTGXSE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269650AbTGXSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:04:55 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13440 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S269661AbTGXSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:04:54 -0400
Date: Thu, 24 Jul 2003 19:29:45 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307241829.h6OITjR3000582@81-2-122-30.bradfords.org.uk>
To: diegocg@teleline.es, rpjday@mindspring.com
Subject: Re: time for some drivers to be removed?
Cc: linux-kernel@vger.kernel.org, ml@basmevissen.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> once upon a time, i suggested having more than one level of module
> "quality".  at the moment, some kernel code is marked as "EXPERIMENTAL"=
> ,
> but this is supported via a regular dependency when it doesn't really
> qualify as a dependency.  dependencies are typically used to refer to
> dependencies on other *code*, not some abstract level of goodness
> like "EXPERIMENTAL".
>
> perhaps it's time to add another category with values like OBSOLETE,
> DEPRECATED, EXPERIMENTAL, BROKEN(?) and so on.  by default, the
> quality would be regular, or something like that.

_NO_!!!

This is a _bad thing_, if a distribution wants to do it to their tree,
fine, but why add extra layers of complexity that a lot of devlopers
don't care about just so that the source tree 'looks nice'?  It's
absolutely pointless, and irritating for anybody actually trying to
work on the codebase.

> and in the end, while i know some folks don't think it's a big
> deal, i think doing a "make allyesconfig" really should work.

It's _counter productive_ just to bodge it so that make allyesconfig
works.  I _want_ it to _fail_ if the drivers are _broken_.

A CONFIG_KNOWN_BROKEN option is a good thing, in the case where,
E.G. a SCSI driver is broken, and will randomly corrupt data, but
otherwise compiles and appears to work.  Apart from that, it's a
complete waste of time to fiddle around with silly options that do
nothing but bloat the codebase and waste developers' time.

John.
