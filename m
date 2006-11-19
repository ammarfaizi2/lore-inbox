Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933385AbWKSVlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWKSVlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbWKSVlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:41:42 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:37083 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933385AbWKSVll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:41:41 -0500
Subject: Re: [patch] PM: suspend/resume debugging should depend on 
	SOFTWARE_SUSPEND
From: Nigel Cunningham <nigelc@bur.st>
Reply-To: nigelc@bur.st
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 08:41:37 +1100
Message-Id: <1163972497.8823.5.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

On Sun, 2006-11-19 at 09:33 -0800, Linus Torvalds wrote:
> 
> On Sun, 19 Nov 2006, Chuck Ebbert wrote:
> >
> > When doing 'make oldconfig' we should ask about suspend/resume
> > debug features when SOFTWARE_SUSPEND is not enabled.
> 
> That's wrong.
> 
> I never use SOFTWARE_SUSPEND, and I think the whole concept is totally 
> broken.
> 
> Sane people use suspend-to-ram, and that's when you need the suspend and 
> resume debugging.
> 
> Software-suspend is silly. I want my machine back in three seconds, not 
> waiting for minutes..

If it's taking minutes, something is wrong. You should be looking at
more like 10-30 seconds, depending on which implementation you're using,
the speed of your cpu and hard disk and how much ram was saved in the
image. For suspend2, for example, the rule of thumb is

ram_in_use_in_MB() / hard_disk_speed() / 2 seconds + bios time + time to
get to starting the resume

Where hard disk speed is the result of hdparm -t. Assumes LZF
compression (that's the /2).

Regards,

Nigel

