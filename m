Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275502AbTHMUc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275505AbTHMUc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:32:29 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13442 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S275502AbTHMUcY (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:32:24 -0400
Date: Wed, 13 Aug 2003 21:40:07 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308132040.h7DKe7VK002065@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, jgarzik@pobox.com
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: davidsen@tmr.com, john@grabjohn.com, Linux-Kernel@vger.kernel.org,
       Riley@Williams.Name, szepe@pinerecords.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The people who want Linux to be reliable won't be compiling their own
> > kernels, typically.  Because, the people that _do_ compile their own
> > kernels have sense enough to disable broken drivers :)  That's what Red
> > Hat, SuSE, and others do today.
>
> It occurs quite often that you need e.g. the latest -pre or -ac to
> support some of your hardware.
>
> These are situations when an average systems administrator has to 
> compile his on kernel.

That is true.  The point is that I don't see how adding an arbitrary
dependency on a CONFIG_BROKEN option actually helps in any way.

Presumably a system administrator who is compiling a -pre or -ac
kernel from kernel.org for a _production_ system is only going to
include drivers that are actually required.  If any of those don't
compile, there is a problem anyway.  If they are hidden under a
CONFIG_BROKEN option, it's just an extra step to enable them, then
compile with them enabled to get an error to post to LKML.

If something is really necessary, why not simply include an ! in the
description of any option that is known not to compile?

John.
