Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTIXWyU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTIXWyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:54:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:18316 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbTIXWyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:54:19 -0400
Date: Wed, 24 Sep 2003 15:54:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, <olof@austin.ibm.com>
Subject: Re: [PATCH] [2.4] Re: /proc/ioports overrun patch
In-Reply-To: <20030924223657.GB7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0309241547360.9506-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Sep 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> 	Umm...  Linus, output truncation is 2.4 problem; any seq_file-based
> variant (including one already in 2.6 and being backported to 2.4) solves
> that.  The thing being, variant we had in 2.6 was ugly - it had walk through
> the tree shoved into ->show() instead of having the iterator do that for
> us.

Yeah, my bad for trying to clean up comments. I just looked at the
seq_printf() usage without error checking, without thinking about the loop 
and checking in the outer layer (ie the seq_read() loop).

Me bad.

You can't undo something in BK (once it is out), but feel free to send me
a patch that adds the appropriate comments, and calls me a pinhead for the
changelog ;)

		Linus

