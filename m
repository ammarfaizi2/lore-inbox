Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTL1AIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTL1AIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:08:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:30175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264889AbTL1AId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:08:33 -0500
Date: Sat, 27 Dec 2003 16:08:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing 2.6.0's broken documentation references
Message-Id: <20031227160834.2de6401d.akpm@osdl.org>
In-Reply-To: <864qvmjtez.fsf@n-dimensional.de>
References: <864qvmjtez.fsf@n-dimensional.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Ulrich Niedermann <linux-kernel@n-dimensional.de> wrote:
>
> Hi,
> 
> I've noted that 2.6.0 contains broken references to documentation.
> 
> I got sufficiently annoyed chasing doc files in the wrong place
> that I wrote a script to check the references to documentation
> files.
> 
> Some documentation files have moved (e.g. Documentation/modules.txt
> to Documentation/kbuild/modules.txt). I adapted the references with a
> script. Patch attached.

Thanks.

> I couldn't find a maintainer for the documentation, the -doc lists are
> dead, so I ask here whether such patches stand a chance to be included
> into the main kernel tree.
> 
> If yes, I'd like to do some more work as described below.
> 
> 1. How to consistently reference to doc files?
> 
>    a) "linux/Documentation/"
>       Still used in some places, but seems to be obsolete, as the top
>       directory is now called "linux-${VERSION}".
> 
>    b) "../../Documentation/foo/bar.txt"
>       There are also places where relative pathes are used. This takes
>       extra space and "Documentation/" should be well-known anyway.
> 
>    c) "Documentation/"
>       Most commonly used. Probably the way to go.

Yes, c).

> 2. Some files have been removed (examples: Configure.help, smp.tex).
>    Fixing this requires manual rewrite of
>    a) code comments
>    b) kbuild help
>    c) Documentation files

We can live with that.  If someone cares enough, they'll fix it.

> 3. Now that I have written a script to scan the source tree, I could
>    also start checking for broken references to http:// and ftp://
>    URLs if desirable.

That wouldn't hurt.
