Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbTARWiJ>; Sat, 18 Jan 2003 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTARWiJ>; Sat, 18 Jan 2003 17:38:09 -0500
Received: from quechua.inka.de ([193.197.184.2]:33970 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265135AbTARWiI>;
	Sat, 18 Jan 2003 17:38:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
Organization: private Linux site, southern Germany
Date: Sat, 18 Jan 2003 23:37:19 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18a1aZ-0006mL-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Use "/lib/modules/`uname -r`/build" as a default kernel directory, but
> > allow it to be overridden somehow from the command line. Then do something
> > like...
>...
> Do you mean I'll need a live Linux kernel to build the kernel module
> package?

Whoever invented this /lib/modules/... scheme should have known that
it provokes this sort of misunderstandings, not to mention is broken
in other ways too.

You need the _source_ of the kernel the module will run on to compile
modules. You don't need to _run_ this kernel while compiling. Putting
build infrastructure into a deployment directory at the least causes
confusion, not to mention that the deployment directory might not even
exist on the development machine. (I routinely compile kernels and
modules of different configurations for three boxes on one of them,
the other two don't even have a complete development toolset.)

Compiling modules is one of the things which always have been among
the most broken things in the kernel build systems, can this please be
fixed and properly documented?

Olaf

