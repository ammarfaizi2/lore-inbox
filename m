Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVEHXhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVEHXhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 19:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVEHXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 19:37:11 -0400
Received: from one.firstfloor.org ([213.235.205.2]:43241 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S263010AbVEHXhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 19:37:02 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 2.6.12-rc3-mm3] perfctr: x86 update with K8 multicore
 fixes
References: <200505081845.j48Ija8i001111@harpo.it.uu.se>
From: Andi Kleen <ak@muc.de>
Date: Mon, 09 May 2005 01:37:01 +0200
In-Reply-To: <200505081845.j48Ija8i001111@harpo.it.uu.se> (Mikael
 Pettersson's message of "Sun, 8 May 2005 20:45:36 +0200 (MEST)")
Message-ID: <m164xtuw6a.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Andrew,
>
> Here's an update for perfctr's x86/x86-64 low-level driver
> which works around issues with current K8 multicore chips.
>
> - Added code to detect multicore K8s and prevent threads in the
>   thread-centric API from using northbridge events. This avoids
>   resource conflicts, and an erratum in Revision E chips.

How about you just check cpu_core_map[] instead of adding your
own custom detection code for this? This seems quite bogus to me.
After all we have central CPU feature detection so that not everybody
reinvents all this on its own.

-Andi

