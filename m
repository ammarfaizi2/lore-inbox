Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWBMS2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBMS2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWBMS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:28:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29662 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932244AbWBMS2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:28:44 -0500
Date: Mon, 13 Feb 2006 13:27:12 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213182712.GA32350@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org> <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org> <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:16:59AM -0800, Linus Torvalds wrote:
 > 
 > 
 > On Mon, 13 Feb 2006, Linus Torvalds wrote:
 > > 
 > > DaveA, I'll apply this for now. Comments?
 > 
 > Btw, the fact that Mauro has the same exact PCI ID (well, lspci stupidly 
 > suppresses the ID entirely, but the string seems to match the one that 
 > Dave Jones reports) may be unrelated.
 > 
 > DaveJ (or Mauro): since you can test this, can you test having that ID 
 > there but _without_ the other changes to drm in -rc1?
 > 
 > Ie was it the addition of that particular ID, or are the other radeon
 > driver changes (which haven't had as much testing) perhaps the culprit?
 >
 > I realize that without the ID, that card would never have been tested 
 > anyway, but the point being that plain 2.6.15 with _just_ that ID added 
 > has at least gotten more testing on other (similar) chips. So before I 
 > revert that particular ID, it would be nice to know that it was broken 
 > even with the previous radeon driver state.

r300 is unlike the other chips though.
Adding that ID on its own doesn't make any sense, as the rest of the
radeon driver won't have a clue how to drive the new hardware.

		Dave

