Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTEBUzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbTEBUze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:55:34 -0400
Received: from ns.suse.de ([213.95.15.193]:26630 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261965AbTEBUzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:55:33 -0400
Date: Fri, 2 May 2003 23:07:58 +0200
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
Message-ID: <20030502210758.GB21239@oldwotan.suse.de>
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com.suse.lists.linux.kernel> <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel> <b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73n0i5138g.fsf@oldwotan.suse.de> <3EB2DB8C.70600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB2DB8C.70600@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 01:56:44PM -0700, H. Peter Anvin wrote:
> Andi Kleen wrote:
> >>
> >>x86-64 definitely does, and it's the default on Linux/x86-64.
> > 
> > No we had to turn it off and now it's too late to turn it back on again.
> > There is also one bug left that prevents it.
> > 
> 
> Why is that?  And, in particular, why is it "too late to turn it back

mprotect() didn't (and probably still does not) work when you change
PROT_EXEC.

> on"?  It seems as long as it's clearly defined as the ABI that change
> can be made later, effectively as a bug fix.

The ABI leaves it undefined. But it does break binaries.

Also gcc needs to be fixed for trampolines (I had some code that enabled 
the stack exec in there, but it didn't work because of the mprotect
issues)

-Andi
