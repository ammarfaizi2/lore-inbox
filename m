Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbUCPAUi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbUCPAS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:18:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:32221 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262969AbUCPAH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:07:26 -0500
Subject: Re: Dealing with swsusp vs. pmdisk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1079381114.5349.62.camel@calvin.wpcb.org.au>
References: <20040312224645.GA326@elf.ucw.cz>
	 <20040313004756.GB5115@thunk.org> <1079146273.1967.63.camel@gaston>
	 <20040313123620.GA3352@openzaurus.ucw.cz>
	 <1079223482.1960.113.camel@gaston>  <20040314003717.GI549@elf.ucw.cz>
	 <1079381114.5349.62.camel@calvin.wpcb.org.au>
Content-Type: text/plain
Message-Id: <1079395292.2302.191.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 11:01:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Freezer hooks (I can easily get suspend2 working with the old freezer
> until people are convinced it's not up to the task). This accounts for
> the vast majority of those file changes.

It would be nice if you did that as a first step indeed. I'm personally
not convinced of the usefullness of having a freezer at all ;)

> - Changes in vmscan to separate out freeing a single LRU page. When
> reading/writing an image, suspend shots down pages added to the LRU list
> as a result of it's activities, so as to keep the contents of the LRU
> the same as at the start of the cycle. I reckon this might be done by
> stopping the pages from being added to the LRU in the first place, but
> haven't gotten around to asking whether this can be safely done. (The
> current method works, so I haven't made it a priority before now). Short
> summary: I freely admit this is ugly and could be done less invasively,
> especially with help from some of the MM guys.
> - I still have to get the console stuff using file descriptors for I/O
> rather than direct calls; I have code there, but it's not being used yet
> because it worked and then got broken. (Shouldn't take much to fix).

Some of the "guard" code you added to the filesystem is scary too..

Ben.


