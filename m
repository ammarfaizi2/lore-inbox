Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261616AbSI2SPZ>; Sun, 29 Sep 2002 14:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSI2SPZ>; Sun, 29 Sep 2002 14:15:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:46981 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261616AbSI2SPY>; Sun, 29 Sep 2002 14:15:24 -0400
Date: Sun, 29 Sep 2002 13:20:44 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Dave Jones <davej@codemonkey.org.uk>
cc: Matt Domsch <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
In-Reply-To: <20020929161144.GA19948@suse.de>
Message-ID: <Pine.LNX.4.44.0209291315010.28578-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Dave Jones wrote:

> On Fri, Sep 27, 2002 at 04:30:29PM -0500, Matt Domsch wrote:
>  >  arch/i386/kernel/edd.c           |  522 +++++++++++++++++++++++++++++++++++++++
>  >  arch/i386/kernel/i386_ksyms.c    |    6 
>  >  arch/i386/kernel/setup.c         |   20 +
> 
> Something that's been bothering me for a while, has been the
> proliferation of 'driver' type things appearing in arch/i386/kernel/
> My initial thought was to move the various CPU related 'drivers'
> (msr,cpuid,bluesmoke,microcode) to arch/i386/cpu/  [1]
> but I'm now wondering if an arch/i386/driver/ would be a better alternative.

Let me add that there are currently two places where arch specific drivers
appear, eg:

	arch/{cris,um}/drivers/
and
	drivers/{s390,macintosh,acorn}/

I think it'd be nice to decide on one way or the other. The first place 
has the advantage of putting all arch-specific stuff into one place, the 
second one makes it (IMO) cleaner to share drivers between e.g. s390 and 
s390x, or possibly i386/x86_64 in the future.

--Kai


