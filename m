Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTEHWf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTEHWe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:34:59 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:47500 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262189AbTEHWda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:33:30 -0400
Date: Thu, 8 May 2003 23:47:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mikpe@csd.uu.se, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore sysenter MSRs at resume
Message-ID: <20030508214737.GD4466@elf.ucw.cz>
References: <16057.16684.101916.709412@gargle.gargle.HOWL> <Pine.LNX.4.44.0305071033400.2997-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305071033400.2997-100000@home.transmeta.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We don't do apm suspend/resume on SMP, so this is no different from the
> > current situation. I don't know if acpi does it or not.
> 
> Well, the thing is, if we ever do want to support it (and I suspect we 
> do), we should have the infrastructure ready. It shouldn't be too hard to 
> support SMP suspend in a 2.7.x timeframe, since it from a technology angle 
> looks like simply hot-plug CPU's. Some of the infrastructure for that 
> already exists.

Actually, then MSRs should restored during hotadd operation, so resume
still does *not* care about non-boot cpus...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
