Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUIHHSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUIHHSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268904AbUIHHSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:18:11 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:63604 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268902AbUIHHSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:18:10 -0400
Date: Wed, 8 Sep 2004 11:18:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mithlesh Thukral <mithlesh@linsyssoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem of debugging modules on x86_64 platform using KGDB
Message-ID: <20040908091819.GA8918@mars.ravnborg.org>
Mail-Followup-To: Mithlesh Thukral <mithlesh@linsyssoft.com>,
	linux-kernel@vger.kernel.org
References: <1094626891.1101.55.camel@krypton>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094626891.1101.55.camel@krypton>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:31:31PM +0530, Mithlesh Thukral wrote:
> hi,
> On the x86_64 platform we faced a problem of debugging modules using
> KGDB. 
> For working around the problem, we need the compile the file
> 'arch/x86_64/kernel/vsyscall.c' without the generation of debugging
> information.
> For this i moved the 'vsyscall.c' from the directory
> 'arch/x86_64/kernel' to a new directory 'arch/x86_64/kernel/vsyscall/' .
> The make file in this new directory does not generate the debugging
> information for the file 'vsyscall.c'.
> Please let me know if there is some other way by which i can specify a
> different set of compilation flags for a single file in the directory.
> this will help me in not moving the file in a new directory.

In arch/x86_64/kernel/Makfile:
CFLAGS_vsyscalls.o := -g0

That should do the trick.

Use make V=1 to check which flags are passed to gcc.
See also Documentation/kbuild/makefiles.txt for reference.

	Sam

