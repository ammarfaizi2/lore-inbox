Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSFFBXY>; Wed, 5 Jun 2002 21:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSFFBXX>; Wed, 5 Jun 2002 21:23:23 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:10398 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316615AbSFFBXO>; Wed, 5 Jun 2002 21:23:14 -0400
Date: Wed, 5 Jun 2002 20:23:12 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206051726400.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206052019310.24284-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Patrick Mochel wrote:

> Alright, I can deal. I expanded on what you had, and moved it into the 
> core. It's not tested, but lemme know what you think. 

Looks fine to me, though I didn't test it either ;-)

However, it's possible to put the struct completion onto the stack
as I suggested, it saves a couple of bytes in struct driver, and, more
importantly, it'll blow up if the refcount goes to zero before 
driver_unregister() has been called, so it provides a bug trap for
messed-up refcounting.

Anyway, that's a question of taste, I suppose.

--Kai

