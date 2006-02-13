Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWBMSU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWBMSU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWBMSU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:20:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932390AbWBMSUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:20:55 -0500
Date: Mon, 13 Feb 2006 10:16:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Linus Torvalds wrote:
> 
> DaveA, I'll apply this for now. Comments?

Btw, the fact that Mauro has the same exact PCI ID (well, lspci stupidly 
suppresses the ID entirely, but the string seems to match the one that 
Dave Jones reports) may be unrelated.

DaveJ (or Mauro): since you can test this, can you test having that ID 
there but _without_ the other changes to drm in -rc1?

Ie was it the addition of that particular ID, or are the other radeon
driver changes (which haven't had as much testing) perhaps the culprit?

I realize that without the ID, that card would never have been tested 
anyway, but the point being that plain 2.6.15 with _just_ that ID added 
has at least gotten more testing on other (similar) chips. So before I 
revert that particular ID, it would be nice to know that it was broken 
even with the previous radeon driver state.

		Linus
