Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGXSTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGXSTr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUGXSTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 14:19:47 -0400
Received: from peabody.ximian.com ([130.57.169.10]:21911 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261987AbUGXSTp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 14:19:45 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Tim Hockin <thockin@hockin.org>
Cc: dsaxena@plexity.net, Michael Clark <michael@metaparadigm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040724174636.GA29367@hockin.org>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
	 <20040724150838.GA24765@plexity.net> <1090683953.2296.78.camel@localhost>
	 <20040724174636.GA29367@hockin.org>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 14:19:43 -0400
Message-Id: <1090693183.12088.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 10:46 -0700, Tim Hockin wrote:

Hey, Tim.

> The things that do can use it, though.  Here's a place where inconsistency
> (if present) is pointless.1

If some things can use the kobject path, we can use it in the argument
field.  I am cool with that - that is exactly what I want, in fact.  But
what we use as the naming convention needs to be something we can use
uniformly.  Unfortunately not everything has a kobject backing it, and
we cannot change that.

> This immediately strikes me as a really bad idea.  Stuff moves between
> files.  Two files might really want to signal an event from the same
> source.  

The signal name would be different.

> As long as we're religious about making every subsystem standardize these
> names, it should be ok.  Another reason to macro-ize.  There are way too
> many people touching too much code that might take advantage of a generic
> kernel->user event to rely on soft rules.

I like your macro-izing idea and the notion of standardizing.  Someone
else brought up a good example: we want _all_ disk drivers to emit the
exact same signal for e.g. "disk full" so user-space can react to it.
It needs to be consistent.  At least for driver error logging, we
definitely want standards and macro-izing.  The translation point is
another good reason for it.

	Robert Love


