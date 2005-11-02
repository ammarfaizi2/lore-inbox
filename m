Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVKBGPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVKBGPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKBGPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:15:15 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:25415 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932134AbVKBGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:15:13 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
X-Message-Flag: Warning: May contain useful information
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
	<20051031160557.7540cd6a.akpm@osdl.org>
	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
	<20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com>
	<Pine.LNX.4.64.0511012142200.27915@g5.osdl.org>
	<52u0eva8yu.fsf@cisco.com>
	<Pine.LNX.4.64.0511012203370.27915@g5.osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 01 Nov 2005 22:15:07 -0800
In-Reply-To: <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> (Linus
 Torvalds's message of "Tue, 1 Nov 2005 22:05:12 -0800 (PST)")
Message-ID: <52ll07a844.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Nov 2005 06:15:08.0931 (UTC) FILETIME=[C67E8D30:01C5DF74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Linus> No, I think that's a lost cause.

    Linus> It doesn't grow by 700 bytes once in a while. It grows by
    Linus> much more, and much more often. And we can't fight it that
    Linus> way, that's just not going to work. Maybe have something
    Linus> that tracks individual object file sizes and shames people
    Linus> into not growing them..

I think we're actually agreeing.  My kmalloc/kzalloc patch is a cute
hack but magic tricks like that aren't going to shrink the kernel by
very much and it's probably not worth merging complications like that.

The way to a smaller kernel is for a lot of people to do a lot of hard
work and look at where we can trim fat.

For your last suggestion, maybe someone can automate running Andi's
bloat-o-meter?  I think the hard part is maintaining comparable configs.

 - R.
