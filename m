Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVEBF1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVEBF1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 01:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVEBF1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 01:27:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:52916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261669AbVEBF07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 01:26:59 -0400
Date: Sun, 1 May 2005 22:26:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Cloos <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-Id: <20050501222630.2fed0bd7.akpm@osdl.org>
In-Reply-To: <m31x8q8bc5.fsf@lugabout.cloos.reno.nv.us>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<m31x8q8bc5.fsf@lugabout.cloos.reno.nv.us>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Cloos <cloos@jhcloos.com> wrote:
>
> Apologies if this has already been asked and I missed it, but do you
> expect to transition to exporting your working tree via git, now that
> licensing concerns are not part of the equation?
> 

Nope.  At any particular point in time the tree I have here has lots of
problems - failing to compile, crashing, etc.  It takes me from four hours
to three days just to get a halfway-respectable release out the door.

So there's no way in which I'd want to make the tree-of-the-minute
externally available - it would muck people around too much and would cause
me to get a ton of email about stuff which I'd probably already fixed.

That, plus a traditional SCM is an inappropriate format for something like
-mm.  This tree is a series of patches against Linus's tree - that's how it
is developed, tested and sent upstream.  Patches get added, dropped,
reordered and merged at any time.  It's hard to explain - you need to have
used patch-scripts or quilt for a while...

Prematurely flattening all this into an SCM view is a fairly pointless
exercise - the only reason for doing it would be for people to be able to
download it.  And they can do that by grabbing the single diff anyway.  I
suppose someone might start offering git -mm trees sometime, as an
alternative to grabbing the diff file.
