Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTBYBUL>; Mon, 24 Feb 2003 20:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTBYBSf>; Mon, 24 Feb 2003 20:18:35 -0500
Received: from dp.samba.org ([66.70.73.150]:4571 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265132AbTBYBSK>;
	Mon, 24 Feb 2003 20:18:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Add module load profile hook 
In-reply-to: Your message of "Mon, 24 Feb 2003 17:16:57 -0000."
             <20030224171657.GA96095@compsoc.man.ac.uk> 
Date: Tue, 25 Feb 2003 12:25:23 +1100
Message-Id: <20030225012823.4FA342C0BA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030224171657.GA96095@compsoc.man.ac.uk> you write:
> So you'll add code in case somebody might want it, but you refuse to fix
> regressions wrt the old code because it's a "corner case" (as if corner
> cases isn't exactly what makes things complicated) ? How odd :)

You still complaining about not stashing the full path name of the
module somewhere in the kernel?

That would be because that was a HACK, and it's my job to say "no",
even when that means we're not "feature complete" by someone's
definition.

You seem to have taken the politeness of my previous response as an
indication of uncertainty.  I am sorry if I gave that impression,
allow me to translate it into Torvaldsian:

	Your patch added a specific "profile_module_loaded()" call
	which did nothing but call a notifier.  Just call a damn
	notifier directly, which is more obvious, more flexible, less
	code and more expandable, and doesn't give you a black star
	for being stupid.

Or, in Viroese, "Vetoed".

Hope that helps 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
