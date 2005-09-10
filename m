Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVIJGcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVIJGcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 02:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVIJGcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 02:32:25 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:58002 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932612AbVIJGcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 02:32:25 -0400
Date: Sat, 10 Sep 2005 08:33:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kbuild: building with a mostly-clean /usr/src/linux and O=
Message-ID: <20050910063352.GA17177@mars.ravnborg.org>
References: <200509062213.52989.agruen@suse.de> <20050906202552.GA17931@mars.ravnborg.org> <200509070303.45009.agruen@suse.de> <431EB0AF02000078000241C0@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431EB0AF02000078000241C0@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 09:19:43AM +0200, Jan Beulich wrote:
> Unfortunately this isn't sufficient, yet. In the architecture-specific
> makefiles asm-offsets.s (or however the specific architectures call
> this) now need their dependencies on include/linux/version.h changed (I
> wonder whether it wouldn't be more efficient to centralize these
> dependencies into an architecture-independent file, perhaps at once
> applying consistent naming across all architectures)

This topic has been on my mind to implment over a long time.
So I took a stamp on it and it hit -linus this night.

Dependencies on arch/$(ARCH)/kernel/asm-offsets.s is now tracked
like any other dependency - so we now at last have full dependency
checks for asm-offsets.h.
Take a look at the Kbuild file in the top-level directory.

With respect to the patch posted below I recall I had to zap
two $(objtree) to fix alpha build.
Patch by Jan Dittmer - see 946dc121d7d1c606f6bbeb8ae778963a1e2ff59c

But that may have changed now after introducing generic asm-offsets.h
support.

	Sam
