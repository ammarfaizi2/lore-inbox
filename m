Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVHCLtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVHCLtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVHCLrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:47:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:19374 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262236AbVHCLpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:45:33 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050802100435.GC1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston>
	 <20050802100435.GC1442@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:41:23 +0200
Message-Id: <1123069285.30257.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 12:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > Why are we calling driver suspend routines in these ? This is _not_ a
> > good idea ! On various machines, the mecanisms for shutting down are
> > quite different from suspend/resume, and current drivers have too many
> > bugs to make that safe. I keep getting all sort of reports of machines
> 
> Well, powerdown at the end of suspend-to-disk should be *very* similar
> to normal powerdown => if device_suspend() breaks something, it is a
> bug in driver anyway.

Power Down != Suspend. Period.

> Now, we may have a lot of such bugs, and the change went in too early,
> but in the long run...

Crap. It's not the same thing.

Ben.


