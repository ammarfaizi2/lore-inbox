Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTEEE2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 00:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTEEE2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 00:28:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261899AbTEEE2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 00:28:45 -0400
Date: Sun, 4 May 2003 21:41:10 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Florin Iucha <florin@iucha.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.69
In-Reply-To: <20030505043058.GG1059@iucha.net>
Message-ID: <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 May 2003, Florin Iucha wrote:
> 
> On SIS 735 motherboard, with agpgart, sis-agp and radeon loaded, I get
> this on the serial console before the machine freezes:
>    agpgart: Found an AGP 2.0 compliant device.
>    agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
>    agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
> Without these modules loaded, the machine is stable.

Make sure to also test with regular 1x AGP (and no fast write stuff etc). 
A lot of motherboards really aren't going to like 4x and some other 
settings (in particular, enabling fast writes seems to be a very iffy 
proposition indeed).

Also, check if the same setup is stable under 2.4.x and possibly using the
DRI CVS tree. Radeon in particular seems to be a lot stabler in DRI these 
days than it has historically been.

Indeed, one of the reasons it took me so long to figure out the stability
issues I saw was simply that there have been real bugs in direct
rendering, and I was blaming them instead and I spent a lot of time trying 
to chase down the bug as an AGP or DRI issue.

		Linus

