Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbTINIl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 04:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTINIl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 04:41:59 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:14976 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262332AbTINIl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 04:41:57 -0400
Date: Sun, 14 Sep 2003 09:52:02 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309140852.h8E8q2ep000355@81-2-122-30.bradfords.org.uk>
To: ak@muc.de, david.lang@digitalinsight.com
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: alan@lxorguk.ukuu.org.uk, bunk@fs.tum.de, davej@redhat.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I don't like the current user interface that says "if you want to
> > > support both an Athlon and a Pentium 4 in your kernel use the Pentium III
> > > option. And for better optimization, also check the "generic" option".

If we go with the bitmap of processors to support idea, the generic option will be unnecessary.

You would then be able to:

* Support, (I.E. include workarounds for, and not include instructions
  that are not supported by), as many or as few processors as you
  desire.

* Optimise, (I.E. set alignment, and code generation within the subset
  of instructions permitted in the 'Support' selection above), for one
  specific processor.

> > The big issue with your ifdefing of workarounds is that it causes subtle
> > support problems. A lot of settings for specific CPUs boot and work
> > fine on other CPUs (possibly with small performance impact, but they're
> > rarely noticeable without explicit benchmarking). Just when you don't
> > include the workarounds for the bugs on these other CPUs it will boot and
> > even run, but fail mysteriously once a month. And that would be a support
> > nightmare.

> it sounds like a nessasary part of this patch would be to detect the CPU
> type and complain VERY loudly if it's not one supported by the build.
>
> This is probably a good idea anyway.

It is a good idea for 99% of kernels, but still needs to be configurable.

Maybe the option should not be present in the kernel configurator, and
require manual editing of the .config file to enable it.

John.
