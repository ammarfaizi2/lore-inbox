Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTKCQjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTKCQjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:39:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:21134 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262052AbTKCQjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:39:51 -0500
Date: Mon, 3 Nov 2003 08:37:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gary Wolfe <gpwolfe@cableone.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [crash/panic] Linux-2.6.0-test9
In-Reply-To: <3FA5FFF7.2020006@cableone.net>
Message-ID: <Pine.LNX.4.44.0311030834230.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Gary Wolfe wrote:
> 
> Tried test8 and, now, test9 and both exhibit same problem.
> 
> The issue seems to be related to the PnPBIOS support under the Plug and 
> Play Kconfig category.  When enabled I get a crash of the form:

Yes. The crash happens inside the BIOS itself, and the kernel doesn't 
really have any control over it. The most Adam could possibly do is to 
avoid calling the BIOS (or at least avoid _certain_ calls), but that would 
require knowing what it is that triggers it.

Has PnP support ever worked for you on this board? Sometimes the solution 
is to just say "it's dead, Jim", and just not enable it. There are few 
enough systems that actually want PnP.

Adam, any ideas?

		Linus

