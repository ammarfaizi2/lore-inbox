Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbUCYW5C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUCYWyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:54:08 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:19841 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263659AbUCYWwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:52:43 -0500
Date: Thu, 25 Mar 2004 23:52:28 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Michael Frank <mhf@linuxmail.org>,
       Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: swsusp is not reliable. Face it. [was Re: [Swsusp-devel] Re: swsusp problems]
Message-ID: <20040325225228.GG2179@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz> <20040324202259.GJ20333@jsambrook> <opr5dwwgzi4evsfm@smtp.pacific.net.th> <20040325221348.GB2179@elf.ucw.cz> <1080250397.6679.28.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080250397.6679.28.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > swsusp1 fails your test, swsusp2 fails your test, and pmdisk fails it,
> > too. If half of memory is used by kmalloc(), there's no sane way to
> > make suspend-to-disk working. And swsusp[12] does not. Granted, half
> > of memory kmalloc-ed is unusual situation, but it can theoreticaly
> > happen. Try mem=8M or something.
> 
> Of course if you do have 8M memory, you're not going to care about
> suspending to disk anyway :>. Note too that suspend2 will eat memory
> until it can suspend. It doesn't livelock because it grabs the memory it
> frees immediately and if it can't free enough, it gives up and exits
> cleanly. You'll know almost instantly if your suspend is going to
> succeed or fail: once you start seeing the image written, the only thing
> that will stop it is media/hardware failure or user intervention.

Yep, swsusp2 will 

a) either fail and exit cleanly

b) or suspend to disk and powerdown

. And that's correct behaviour. Michael apparently wants suspend that
always suspends, and never refuses, but not even swsusp2 can do
that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
