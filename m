Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUFVTwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUFVTwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUFVTtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:49:24 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:40604 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265058AbUFVTp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:45:57 -0400
Date: Tue, 22 Jun 2004 14:45:36 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: Andrew Morton OSDL <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
In-Reply-To: <1087650315.8188.915.camel@cube>
Message-ID: <Pine.SGI.4.58.0406221426580.27967@kzerza.americas.sgi.com>
References: <1087605785.8188.834.camel@cube>  <20040619030637.5580b25e.akpm@osdl.org>
 <1087650315.8188.915.camel@cube>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Albert Cahalan wrote:

> I'm not so sure anything needs to be fixed, save for SGI upgrading
> to a more modern procps. There are many more important things:

OK, I looked into this more closely, and gave procps 3.2.1 a spin.
This gives us a similar speedup (top now only consumes 60% of a CPU)
to that which I obtained by cacheing symbol lookups and using an old
procps.  This difference is certainly explainable by top now only
obtaining wchan information for displayed processes.

60% is far better than 800%, so this is certainly progress.  However
60% is also still quite a bit of CPU time.  I'll spend some cycles
trying to whittle it down some more, but I'm not all that hopeful.

Thanks for the discussion, it was certainly enlightening.

Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
