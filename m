Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTAVU0i>; Wed, 22 Jan 2003 15:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbTAVU0i>; Wed, 22 Jan 2003 15:26:38 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:21128 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262812AbTAVU0h>; Wed, 22 Jan 2003 15:26:37 -0500
Date: Wed, 22 Jan 2003 14:35:38 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Andrew Morton <akpm@digeo.com>
cc: Kevin Lawton <kevinlawton2001@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please
 consider)
In-Reply-To: <20030122121712.19f19dac.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301221434270.9969-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Andrew Morton wrote:

> 	#include <asm/if.h>
> 
> in the places which are known to use pushfl/popfl is fragile.  Because
> someone could later do something odd which results in the generation of an
> unmassaged pushfl/popfl.
> 
> You need a magic bullet.  Which is why I suggest including if.h via the build
> system - making it truly global.
> 
> __ASSEMBLY__ and __KERNEL__ are provided via the build system as well, and
> are in scope during that first inclusion.  So it _should_ work....

Let me just mention "gcc -include <file>". I suppose that's what you were 
saying, anyway.

--Kai

