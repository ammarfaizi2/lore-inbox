Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbTGCIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTGCIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:07:28 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:14484 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265552AbTGCIH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:07:26 -0400
Date: Thu, 3 Jul 2003 10:21:44 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: david nicol <whatever@davidnicol.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: build from RO source tree?
In-Reply-To: <1057193186.966.17.camel@plaza.davidnicol.com>
Message-ID: <Pine.GSO.4.21.0307031020410.4422-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Jul 2003, david nicol wrote:
> On Wed, 2003-07-02 at 09:15, Geert Uytterhoeven wrote:
> > Subject: [PATCH] touchless dependencies for 2.4.x
> > The 2.4.x dependency system depends on being able to `touch' include files in
> > case of recursive dependencies.  This fails when using a revision control
> > system (e.g. ClearCase) where non-checked out files are read-only and cannot be
> > touch'ed.
> > 
> > The patch below solves this by making object files depend on (recursive) lists,
> > containing the list of dependencies for each header file.
> 
> So with this patch applied you can safely build in a lndir against
> a RO media. but without it you can't?  

The current 2.4 build system always touches includes files. If your source tree
is RO, the touches will fail.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

