Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSHBRqX>; Fri, 2 Aug 2002 13:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSHBRqV>; Fri, 2 Aug 2002 13:46:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25255 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316213AbSHBRpt>; Fri, 2 Aug 2002 13:45:49 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208021748.g72HmnV08218@devserv.devel.redhat.com>
Subject: Re: Accelerating user mode linux
To: jdike@karaya.com (Jeff Dike)
Date: Fri, 2 Aug 2002 13:48:49 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200208021828.NAA02466@ccure.karaya.com> from "Jeff Dike" at Aug 02, 2002 01:28:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, there's nothing special about entering userspace for the first time.
> Everything is under a signal frame, so any time something needs to enter
> userspace, it just returns through it.

Ok

> This has the slight disadvantage that the process address space isn't directly
> accessible, but I can live with that.  A virt_to_phys translation isn't too
> painful.

Right

> This raises the question of how the process address spaces are created.  For
> a variety of reasons unrelated to altmm (which I can go into if anyone's
> interested), I want address spaces to be separate user-visible objects.  

That really makes all the existing code not work with it. Doing an altmm
is easy in the sense that it doesn't require 20 new syscall and doesnt
slow down the main kernel paths for a single odd case.

I can see why there is a need to manipulate the other mm I need to think
about the right way to handle it.
