Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTI3IRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbTI3IRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:17:13 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:64896 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261152AbTI3IRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:17:11 -0400
Date: Tue, 30 Sep 2003 09:17:16 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309300817.h8U8HGrf000881@81-2-122-30.bradfords.org.uk>
To: Jamie Lokier <jamie@shareable.org>, akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard.brunner@amd.com
In-Reply-To: <20030930073814.GA26649@mail.jlokier.co.uk>
References:  <20030930073814.GA26649@mail.jlokier.co.uk>
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch

Quote from Jamie Lokier <jamie@shareable.org>:

>    2. Nevertheless, when a kernel _not_ optimised for those AMD processors
>       is run on one, the "alternative" mechanism now correctly replaces
>       prefetch instructions with nops.

> It's a reasonable argument that if a kernel version, say 2.6.0, promises
> to hide the errata from _userspace_ programs, then the generic or
> not-AMD-optimised kernels should do that too.  Otherwise userspace may
> as well provide the workaround itself, by catching SIGSEGV - because it
> is perfectly normal and common to run a generic kernel on an AMD.

This problem, and others like it, would be solved for ever with
Adrian's bitmap-of-supported-cpus patch, though.  With that, there is
no 'generic' kernel, either it supports Athlons, or it doesn't.  100%
elimination of Athlon specific code for other CPUs.  Everybody is
happy.

Of course a kernel compiled strictly for 386s may seem to boot on an
Athlon but not work properly.  So what?  Just don't run the 'wrong'
kernel.

John.
